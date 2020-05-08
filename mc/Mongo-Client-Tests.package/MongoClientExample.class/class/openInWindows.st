examples
openInWindows
	"Open windows to execute the example."

	<example>
	| aWorkspace contents |

	"Open (and clean) Transcript."
	Transcript open; clear.

	"Show the example script."
	contents := Character cr join: ((self class sourceCodeAt: #scriptCode) lines allButFirst: 2).
	aWorkspace := Smalltalk tools workspace openContents: contents.
	aWorkspace label: 'Example'.
	
	"Show the replica set scenario."
	contents := ('This example uses the replica set scenario explained in the class comment of ', MongoReplicationTestResources name, ':
	
', MongoReplicationTestResources comment) surroundedBy: '"'.
	aWorkspace := Smalltalk tools workspace openContents: contents.
	aWorkspace label: 'Replica Set Scenario'.
	
