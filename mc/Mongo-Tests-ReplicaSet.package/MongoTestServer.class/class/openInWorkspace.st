examples
openInWorkspace
	<example>
	| workspace code |
	code := Character cr
		join: ((self class sourceCodeAt: #workspaceCode) lines allButFirst: 2).
	workspace := Smalltalk tools workspace openContents: code.
	workspace title: 'Example'