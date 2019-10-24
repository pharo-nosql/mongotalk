examples
openInWorkspace
	<example>
	| workspace code |
	code := (self class sourceCodeAt: #workspaceCode) allButFirst: #workspaceCode size.
	workspace := Smalltalk tools workspace
		openContents: code.
	workspace label: 'Example'