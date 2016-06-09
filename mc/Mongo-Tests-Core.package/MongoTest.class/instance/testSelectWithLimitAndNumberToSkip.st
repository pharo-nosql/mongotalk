tests
testSelectWithLimitAndNumberToSkip
	| firstBatch secondBatch |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection add: (Dictionary new at: 'key3' put: 'value3'; yourself).
	firstBatch := collection query: [ :query | query
		where: Dictionary new;
		limit: 2 ].
	secondBatch := collection query: [ :query | query
		where: Dictionary new;
		limit: 2;
		offset: 2 ].
	self assert: firstBatch size equals: 2.
	self assert: secondBatch size equals: 1.
	