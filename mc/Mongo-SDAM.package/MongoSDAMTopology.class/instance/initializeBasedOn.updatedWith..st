initialization
initializeBasedOn: anotherMongoSDAMTopology updatedWith: aMongoSDAMServerDescription
	self initialize.

	"Base on another's dictionary of servers, but override with the new server description."
	serversByUrlString := anotherMongoSDAMTopology serversByUrlString deepCopy.
	self updateServer: aMongoSDAMServerDescription.

	aMongoSDAMServerDescription isSuccess ifFalse: [
		self flag: #todo. "Add some behavior..."
		^self ].

	aMongoSDAMServerDescription isMaster isReplicaSet
		ifTrue: [
			aMongoSDAMServerDescription isMaster hasPrimary
				ifTrue: [
					type := MongoSDAMTopologyType replicaSetWithPrimary.
					primaryUrlString := aMongoSDAMServerDescription isMaster primaryUrlString ]
				ifFalse: [ 
					type := MongoSDAMTopologyType replicaSetNoPrimary.
					primaryUrlString := nil ].
			secondaryUrlStrings := aMongoSDAMServerDescription isMaster replicaSetHosts, aMongoSDAMServerDescription isMaster replicaSetPassives.
		]
		ifFalse: [ self shouldBeImplemented 
			"Check https://docs.mongodb.com/v3.4/reference/command/isMaster/" ].