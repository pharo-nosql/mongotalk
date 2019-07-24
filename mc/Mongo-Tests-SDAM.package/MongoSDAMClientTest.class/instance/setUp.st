running
setUp
	| duration |
	super setUp.

	Transcript cr; cr; show: testSelector; << ' setUp '; cr.
	duration := [ self ensureTestingScenario ] timeToRun.
	Transcript space; print: duration; cr.
