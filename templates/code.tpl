<link rel="stylesheet" href="https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css" integrity="sha384-dNpIIXE8U05kAbPhy3G1cz+yZmTzA6CY8Vg/u2L9xRnHjJiAK76m2BIEaSEV+/aU" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://cdn.intercoolerjs.org/intercooler-1.0.3.min.js"></script>

<link rel="stylesheet" href="/css/editor.css">

<div id="page">
	<textarea name="code" id="code" style="display: none;"></textarea>
	<div id="editor" name="code">{{ code }}</div>

	<div class="ace-vibrant-ink">
	<button id="upload"
	ic-post-to="/{{ serial }}" ic-include="#code" ic-target="#message"
	ic-on-success="addHistory()"
	onclick="$('#code').val(editor.getSession().getValue());">
		<i class="fa fa-upload"></i>
		Upload
		<i class="fa fa-spinner fa-spin ic-indicator" style="display:none"></i>
	</button>
	</div>

	<div id="message">
	</div>
</div>

<script src="/ace/ace.js" type="text/javascript" charset="utf-8"></script>
<script>
	var editor = ace.edit("editor");
	editor.$blockScrolling = Infinity;
	editor.setTheme("ace/theme/vibrant_ink");
	editor.getSession().setMode("ace/mode/arduino");

	window.onpopstate = function(event) {
		editor.setValue(event.state.code);
		editor.clearSelection();
	};

	var editNum = 0;
	function addHistory() {
		var codeState = {code: $('#code').val()};
		history.pushState(codeState, 'Arduino - edit: '+(editNum++), '?'+$.param(codeState));
	}
</script>
