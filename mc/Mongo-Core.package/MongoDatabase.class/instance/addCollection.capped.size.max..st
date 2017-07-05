private
addCollection: aString capped: aCapped size: aSize max: aMax
	| command |
	command := OrderedIdentityDictionary new
					at: #create put: aString;
					yourself.
	aCapped ifTrue: [
		command at: #capped put: true.
		aSize ifNotNil: [command at: #size put: aSize].
		aMax ifNotNil: [command at: #max put: aMax]].
	[ self command: command ]
		on: MongoCommandError
		do: [ :error |
			"Tolerate error 48: collection already exists"
			error isCollectionAlreadyExists
				ifTrue: [ (MongoCollectionAlreadyExists new collectionName: aString) signal ]
				ifFalse: [ error signal ] ].
	^MongoCollection database: self name: aString