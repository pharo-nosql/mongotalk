initialization
overcomeErrorBasedOn: anotherMongoTopology updatedWith: aMongoServerDescription

	aMongoServerDescription urlString = anotherMongoTopology primaryUrlString
		ifTrue: [
			type := MongoTopologyType replicaSetNoPrimary.
			primaryUrlString := nil ]
		ifFalse: [ 
			"Keep main status if it was an error with a secondary server."
			type := anotherMongoTopology type.
			primaryUrlString := anotherMongoTopology primaryUrlString ].
	
	"In any case, keep secondaries."
	secondaryUrlStrings := anotherMongoTopology secondaryUrlStrings.