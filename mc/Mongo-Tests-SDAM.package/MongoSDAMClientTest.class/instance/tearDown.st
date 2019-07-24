running
tearDown
	| duration |
	super tearDown.

	Transcript cr; show: testSelector; << ' tearDown '; cr.
	duration := [ self ensureTestingScenario ] timeToRun.
	Transcript space; print: duration; cr.

	client ifNotNil: [ client stop ]