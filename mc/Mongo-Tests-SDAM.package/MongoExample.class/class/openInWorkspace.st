examples
openInWorkspace
	"Open windows to execute the example."

	<example>
	| workspace code |
	Transcript
		open;
		clear.
	code := Character lf
		join: ((self class sourceCodeAt: #workspaceCode) lines allButFirst: 2).
	workspace := Smalltalk tools workspace openContents: code.
	workspace label: 'Example'