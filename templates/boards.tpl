<link rel="stylesheet" href="https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css" integrity="sha384-dNpIIXE8U05kAbPhy3G1cz+yZmTzA6CY8Vg/u2L9xRnHjJiAK76m2BIEaSEV+/aU" crossorigin="anonymous">

<link rel="stylesheet" href="/css/boards.css">

<ul id="boards">
% for board in boards:
	<li>
		<a href="/{{ board['serial'] }}">
			<div class="board">
				<div class="lcd">
					{{ board['name'] }}
				</div>
				<div class="shift-register">
				% for led in bin(board['id']).lstrip('0b').rjust(8, '0'):
					% if led == '1':
						<i class="led-on"></i>
					% else:
						<i class="led-off"></i>
					% end
				% end
				</div>
			</div>
		</a>
	</li>
% end
</ul>
% if len(boards) == 0:
	<h2>No boards connected</h2>
% end

% if no_config:
<div id="message">
	I don't know where to look for the boards. Make sure you add the following lines to config.ini
	<code><pre>[arduino]
	device_dir = [device directory e.g. /dev]
	device_prefix = [the pattern at the start of the name of every device e.g. cu.usbserial-]
	</pre></code>
</div>
% end
