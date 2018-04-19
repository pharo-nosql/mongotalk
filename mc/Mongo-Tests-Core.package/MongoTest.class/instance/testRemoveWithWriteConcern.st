tests
testRemoveWithWriteConcern
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: collection size = 1.
	collection commandDelete: data limit: 1 writeConcern: self aWriteConcern.
	self assert: collection isEmpty