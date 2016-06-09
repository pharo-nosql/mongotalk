tests
testInsertAndQueryWithFields
	| results |
	collection add: (Dictionary new 
		at: 'key' put: 'value'; 
		at: 'foo' put: 'bar'; 
		yourself).
	results := collection query: [ :query | 
		query
			where: Dictionary new;
			fields: (Dictionary new at: 'foo' put: 'bar'; yourself) ].
	self assert: results size = 1.
	self assert: (results first at: 'foo') = 'bar'.
	self deny: (results first includesKey: 'key')