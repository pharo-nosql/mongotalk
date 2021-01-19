tests
testUpdateWithWriteConcernError100
	"Attempts to update a document with an invalid write concern. Verify that this
	raises an exception (the actual effect on the collection will still happen)."

	| result old new concern |
	concern := MongoWriteConcern new
		w: 50;
		yourself.
	old := { 'key' -> 'value' } asDictionary.
	new := { 'key' -> 'new value' } asDictionary.
	collection add: old.

	self
		should: [ collection commandUpdate: old with: new writeConcern: concern ]
		raise: MongoCommandError
		withExceptionDo: [ :ex |
			self assert: ex code equals: 100.
			self assert: ex errorMessage equals: 'Not enough data-bearing nodes' ].

	result := collection query: [ :query |  ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'
