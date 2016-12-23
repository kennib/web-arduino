<link rel="stylesheet" href="https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css" integrity="sha384-dNpIIXE8U05kAbPhy3G1cz+yZmTzA6CY8Vg/u2L9xRnHjJiAK76m2BIEaSEV+/aU" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="http://cdn.intercoolerjs.org/intercooler-1.0.3.min.js"></script>

<textarea name="code" id="code" style="display: none;"></textarea>
<div id="editor" name="code" style="width:100%; height:80%;">{{ code }}</div>
<button ic-post-to="/{{ serial }}" ic-include="#code" ic-target="#error"
onclick="$('#code').val(editor.getSession().getValue());">
	Upload <i class="fa fa-spinner fa-spin ic-indicator" style="display:none"></i>
</button>

<div id="error">
</div>

<script src="/ace/ace.js" type="text/javascript" charset="utf-8"></script>
<script>
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/vibrant_ink");
	editor.getSession().setMode("ace/mode/arduino");
</script>
