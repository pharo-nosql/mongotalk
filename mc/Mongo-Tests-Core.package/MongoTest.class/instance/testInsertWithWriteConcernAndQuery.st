tests
testInsertWithWriteConcernAndQuery
	| results |
	collection 
		commandInsert: (Dictionary new at: 'key' put: 'value'; yourself) 
		writeConcern: self aWriteConcern.
	results := collection query: [ :query | ].
	self assert: results size equals: 1.
	self assert: (results first at: 'key') = 'value'