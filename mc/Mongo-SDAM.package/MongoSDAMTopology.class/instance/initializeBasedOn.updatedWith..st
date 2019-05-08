initialization
initializeBasedOn: anotherMongoSDAMTopology updatedWith: aMongoIsmaster
	self initialize.
	
	servers := anotherMongoSDAMTopology servers deepCopy.

	aMongoIsmaster isReplicaSet
		ifTrue: [
			aMongoIsmaster hasPrimary
				ifTrue: [
					type := MongoSDAMTopologyType replicaSetWithPrimary.
					primaryUrlString := aMongoIsmaster primaryUrlString.
					secondaryUrlStrings := aMongoIsmaster hosts asSet ]
				ifFalse: [ 
					type := MongoSDAMTopologyType replicaSetNoPrimary.
					self shouldBeImplemented ]
		]
		ifFalse: [ self shouldBeImplemented 
			"Check https://docs.mongodb.com/v3.4/reference/command/isMaster/" ].