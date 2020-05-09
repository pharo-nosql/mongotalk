testing
hasDifferenceWith: anotherMongoServerDescription
	self differencesFrom: anotherMongoServerDescription do: [ ^ true ].
	^ false