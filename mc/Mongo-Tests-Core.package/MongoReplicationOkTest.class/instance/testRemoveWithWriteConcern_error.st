tests
testRemoveWithWriteConcern_error
	| data concern |
	"Removes an entry from the collection with an impossible write concern and
	verifies that an exception is raised. The document is still deleted from the
	collection."
	concern := MongoWriteConcern new w: 1000; yourself.
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: collection size equals: 1.
	self
		should: [collection commandDelete: data limit: 1 writeConcern: concern]
		raise: MongoCommandError
		withExceptionDo: [:ex |
			self assert: ex code equals: 100.
			self assert: ex errorMessage equals: 'Not enough data-bearing nodes'].
	self assert: collection isEmpty.