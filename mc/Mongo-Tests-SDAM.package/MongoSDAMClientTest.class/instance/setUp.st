running
setUp
	| duration |
	super setUp.

	Transcript cr; cr; show: testSelector; << ' setUp '; cr.
	duration := [ self ensureDeleteDatabaseForTesting ] timeToRun.
	Transcript space; print: duration; cr.
