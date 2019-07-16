running
tearDown
	| duration |
	super tearDown.

	Transcript cr; show: testSelector; << ' tearDown '; cr.
	duration := [ self ensureDeleteDatabaseForTesting ] timeToRun.
	Transcript space; print: duration; cr.

	client ifNotNil: [ client stop ]