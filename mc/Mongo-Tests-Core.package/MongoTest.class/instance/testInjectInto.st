tests
testInjectInto
	collection add: (Dictionary new at: 'key' put: 2; yourself).
	collection add: (Dictionary new at: 'key' put: 3; yourself).
	self assert: (collection inject: 0 into: [:sum :each | sum + (each at: 'key')]) = 5