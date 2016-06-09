tests
testType
	| selected |
	collection add: (Dictionary new at: 'key1' put: 1; yourself).
	collection add: (Dictionary new at: 'key1' put: 'hello';  yourself).
	
	self assert: (collection select: [ :each | each key1 type = 16 ]) size equals: 1.
	self should: [ collection select: [ :each | each key1 type =  'string' ] ] raise: MQQueryError 