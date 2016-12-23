<form method="POST">
	<div id="editor" name="code" style="width:100%; height:80%;">{{ code }}</div>
	<input type="submit" value="Upload"></input>
</form>

<script src="/ace/ace.js" type="text/javascript" charset="utf-8"></script>
<script>
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/vibrant_ink");
	editor.getSession().setMode("ace/mode/arduino");
</script>
