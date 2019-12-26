testing - common
hasDifferenceWith: anotherMongoIsMaster
	self differencesFrom: anotherMongoIsMaster do: [ ^ true ].
	^ false