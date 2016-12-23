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
