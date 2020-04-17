testing
hasDifferenceWith: anotherMongoIsMaster
	self differencesFrom: anotherMongoIsMaster do: [ ^ true ].
	^ false