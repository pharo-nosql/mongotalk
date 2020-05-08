initialization
overcomeErrorBasedOn: anotherMongoSDAMTopology updatedWith: aMongoSDAMServerDescription

	aMongoSDAMServerDescription urlString = anotherMongoSDAMTopology primaryUrlString
		ifTrue: [
			type := MongoTopologyType replicaSetNoPrimary.
			primaryUrlString := nil ]
		ifFalse: [ 
			"Keep main status if it was an error with a secondary server."
			type := anotherMongoSDAMTopology type.
			primaryUrlString := anotherMongoSDAMTopology primaryUrlString ].
	
	"In any case, keep secondaries."
	secondaryUrlStrings := anotherMongoSDAMTopology secondaryUrlStrings.