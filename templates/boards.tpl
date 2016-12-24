<ul>
% for board in boards:
	<li>
		<a href="/{{board}}">Board {{ board }}</a>
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
