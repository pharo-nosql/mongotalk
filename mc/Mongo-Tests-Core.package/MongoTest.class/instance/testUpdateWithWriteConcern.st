tests
testUpdateWithWriteConcern
	| result old new |
	old := { 'key' -> 'value' } asDictionary.
	new := { 'key' -> 'new value' } asDictionary.

	collection add: old.
	collection commandUpdate: old with: new writeConcern: self aWriteConcern.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'.
