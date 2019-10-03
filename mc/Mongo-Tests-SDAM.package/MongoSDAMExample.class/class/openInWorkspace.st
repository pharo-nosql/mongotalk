examples
openInWorkspace
	<example>
	| workspace |
	workspace := Smalltalk tools workspace
		openContents:
			'example := MongoSDAMExample new. 
example start.

example stop.
Transcript clear.

MongoReplicationTestResources signalStopA.
MongoReplicationTestResources signalStopB.
MongoReplicationTestResources signalStopC.

MongoReplicationTestResources signalContinueA.
MongoReplicationTestResources signalContinueB.
MongoReplicationTestResources signalContinueC.

MongoReplicationTestResources stepDownA: 10 seconds.
MongoReplicationTestResources stepDownB: 120 seconds.

example write.
example read.

'.
	workspace label: 'Example'