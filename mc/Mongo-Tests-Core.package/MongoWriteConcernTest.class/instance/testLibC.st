tests-as yet unclassified
testLibC
	Stdio stdout << 'testLibC.1'; cr.
	LibC system: 'ls'.
	Stdio stdout << 'testLibC.2'; cr.
	MongoReplicationTestResources signalContinueA.
	Stdio stdout << 'testLibC.3'; cr.
	Stdio stderr << 'testLibC'; cr.
