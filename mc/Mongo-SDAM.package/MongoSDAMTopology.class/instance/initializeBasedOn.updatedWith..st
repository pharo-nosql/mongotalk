initialization
initializeBasedOn: anotherMongoSDAMTopology updatedWith: aMongoSDAMServerDescription
	| isMaster |
	self initialize.

	"Base on another's dictionary of servers, but override with the new server description."
	serversByUrlString := anotherMongoSDAMTopology serversByUrlString deepCopy.
	self updateServer: aMongoSDAMServerDescription.

	"Keep type until next success"
	type := anotherMongoSDAMTopology type.

	aMongoSDAMServerDescription isSuccess ifFalse: [ ^self ].

	isMaster := aMongoSDAMServerDescription isMaster.

	isMaster isReplicaSet
		ifTrue: [
			isMaster hasPrimary
				ifTrue: [
					type := MongoSDAMTopologyType replicaSetWithPrimary.
					primaryUrlString := isMaster primaryUrlString ]
				ifFalse: [ 
					type := MongoSDAMTopologyType replicaSetNoPrimary.
					primaryUrlString := nil ].
			secondaryUrlStrings := Array streamContents: [ :stream |
				| block |
				block := [ :each | each = primaryUrlString ifFalse: [ stream nextPut: each ] ].
				isMaster replicaSetHosts do: block.
				isMaster replicaSetPassives do: block. ].
		]
		ifFalse: [ self shouldBeImplemented 
			"Check https://docs.mongodb.com/v3.4/reference/command/isMaster/" ].