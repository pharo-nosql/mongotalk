tests
testUpdateWithFlags
	| result old new |
	old := { 'key' -> 'value' } asDictionary.
	new := { 'key' -> 'new value' } asDictionary.

	"Check that a normal update will not create anything"
	collection update: old with: new.
	result := collection query: [:query | ].
	self assert: result size equals: 0.

	"Check that an upsert will create the record"
	collection update: old with: new flags: UpdateOperation flagUpsert.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'.

	"And Go back"
	collection update: new with: old.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'value'.

	"And forward again"
	collection update: old with: new flags: UpdateOperation flagUpsert.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'.