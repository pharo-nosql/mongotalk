tests
testInitialTopologyIsUnknown

	client := self newClient.
	self assert: client topology isTypeUnknown.
	client start.
	self assert: client topology isTypeUnknown.
	10 milliSeconds wait.
	self deny: client topology isTypeUnknown.
