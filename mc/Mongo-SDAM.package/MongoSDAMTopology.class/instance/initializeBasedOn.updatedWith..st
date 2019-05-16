initialization
initializeBasedOn: anotherMongoSDAMTopology updatedWith: aMongoSDAMServerDescription
	self initialize.

	serversByUrlString := anotherMongoSDAMTopology serversByUrlString deepCopy.
	self updateServer: aMongoSDAMServerDescription.

	aMongoSDAMServerDescription isSuccess ifFalse: [
		self flag: #todo. "Add some behavior..."
		^self ].

	aMongoSDAMServerDescription ismaster isReplicaSet
		ifTrue: [
			aMongoSDAMServerDescription ismaster hasPrimary
				ifTrue: [
					type := MongoSDAMTopologyType replicaSetWithPrimary.
					primaryUrlString := aMongoSDAMServerDescription ismaster primaryUrlString ]
				ifFalse: [ 
					type := MongoSDAMTopologyType replicaSetNoPrimary.
					primaryUrlString := nil ].
			secondaryUrlStrings := aMongoSDAMServerDescription ismaster hosts asSet.
		]
		ifFalse: [ self shouldBeImplemented 
			"Check https://docs.mongodb.com/v3.4/reference/command/isMaster/" ].