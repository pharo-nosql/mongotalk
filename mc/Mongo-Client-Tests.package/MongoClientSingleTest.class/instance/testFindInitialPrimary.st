tests - monitoring
testFindInitialPrimary

	| topology |
	client := self newClient.
	self startClientAndWait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeSingle.
	self assert: topology primaryUrl equals: self urlToTest.
