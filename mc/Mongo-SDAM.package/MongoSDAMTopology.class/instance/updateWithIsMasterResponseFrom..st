initialization
updateWithIsMasterResponseFrom: aMongoSDAMServerDescription
	| isMaster |
	isMaster := aMongoSDAMServerDescription isMaster.

	isMaster isSharded ifTrue: [ self shouldBeImplemented ].

	isMaster isReplicaSet ifFalse: [
		type := MongoSDAMTopologyType single.
		primaryUrlString := aMongoSDAMServerDescription urlString.
		^ self ].

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
