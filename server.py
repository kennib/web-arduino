#/usr/bin/env python3

import re
import subprocess
from os import listdir, chdir, path
import bottle
from bottle import route, post, request, run, template, static_file

# Get web arduino config
from configparser import SafeConfigParser

config = SafeConfigParser()
config.read('config.ini')

ARDUINO_DIR = config.get('arduino', 'arduino_dir', fallback=None)
DEVICE_DIR = config.get('arduino', 'device_dir', fallback=None)
DEVICE_PREFIX = config.get('arduino', 'device_prefix', fallback=None)
BOARD_TAG = config.get('arduino', 'board_tag', fallback=None)
BOARD_SUB = config.get('arduino', 'board_sub', fallback=None)

MAKEFILE = config.get('arduino', 'makefile_path', fallback='./Makefile')
CODE_DIR = config.get('arduino', 'code_dir', fallback='./code')

HOST = config.get('web', 'host', fallback='127.0.0.1')
PORT = config.get('web', 'port', fallback='8888')

# Templates directory
bottle.TEMPLATE_PATH.append('./templates')

# Ace text editor static files
@route('/ace/<filename:path>')
def ace(filename):
	return static_file(filename, root='./ace')

# CSS static files
@route('/css/<filename:path>')
def ace(filename):
	return static_file(filename, root='./css')

# Index page
@route('/')
def index():
	if DEVICE_DIR:
		devices = listdir(path=DEVICE_DIR)
		serials = [device.lstrip(DEVICE_PREFIX) for device in devices if device.startswith(DEVICE_PREFIX)]
		boards = [{'id': id, 'serial': serial} for id, serial in enumerate(serials)]
		no_config = False
	else:
		boards = []
		no_config = True

	return template('boards', boards=boards, no_config=no_config)

# Code writing page (per board)
@route('/<serial:re:\w+>')
def code(serial):
	code = request.params.get('code')
	if not code:
		code = open(path.join(CODE_DIR, 'examples', 'Blink.ino')).read()

	return template('code', serial=serial, code=code)

# Code submission page (per board)
@post('/<serial:re:\w+>')
def upload(serial):
	# The submitted code
	code = request.params.get('code')

	# Get absolute paths for the makefile, code and board
	makefile = path.abspath(MAKEFILE)
	code_dir = path.abspath(CODE_DIR)
	board_dir = path.abspath(path.join(code_dir, serial))
	device = path.join(DEVICE_DIR, DEVICE_PREFIX+serial)

	# Create a directory for the code
	if path.commonpath([code_dir, board_dir]) == code_dir:
		subprocess.run(['mkdir', '-p', board_dir], check=True)
		subprocess.run(['ln', '-F', '-s', makefile, board_dir])

		# Write, compile and upload the code
		with open(path.join(board_dir, 'Code.ino'), 'w') as code_file:
			code_file.write(code)

		build = subprocess.run(['make',
			'-C', board_dir,
			'ARDUINO_DIR='+ARDUINO_DIR,
			'BOARD_TAG='+BOARD_TAG,
			'BOARD_SUB='+BOARD_SUB,
			'MONITOR_PORT='+device
		],
		stdout=subprocess.PIPE, stderr=subprocess.PIPE)

		if build.returncode:
			error = re.sub('make:.*|.*?Arduino.mk:\d+: ', '', build.stderr.decode())
			return template('error', error=error)

		upload = subprocess.run(['make',
			'-C', board_dir,
			'upload',
			'ARDUINO_DIR='+ARDUINO_DIR,
			'BOARD_TAG='+BOARD_TAG,
			'BOARD_SUB='+BOARD_SUB,
			'MONITOR_PORT='+device
		],
		stdout=subprocess.PIPE, stderr=subprocess.PIPE)

		if upload.returncode:
			error = re.sub('make:.*|.*?Arduino.mk:\d+: ', '', upload.stderr.decode())
			return template('error', error=error)

	return template('success', message='Uploaded!')


if __name__ == '__main__':
	run(server='cherrypy', host=HOST, port=PORT, reloader=True)
