tests
testSize
	| selected |
	collection add: (Dictionary new at: 'key1' put: #(1 2 3 4 5); yourself).
	collection add: (Dictionary new at: 'key1' put: 'hello';  yourself).
	
	self assert: (collection select: [ :each | each key1 size = 5 ]) size equals: 1.
	self should: [ collection select: [ :each | each key1 size =  'string' ] ] raise: MQQueryError 