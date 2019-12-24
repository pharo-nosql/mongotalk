examples
openInWorkspace
	<example>
	| workspace code |
	code := Character lf join: ((self class sourceCodeAt: #workspaceCode) lines allButFirst: 2).
	workspace := Smalltalk tools workspace openContents: code.
	workspace label: 'Example'