testing
hasDifferenceWith: anotherMongoSDAMServerDescription
	self differencesFrom: anotherMongoSDAMServerDescription do: [ ^ true ].
	^ false