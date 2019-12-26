initialization
updateWithIsMasterResponseFrom: aMongoSDAMServerDescription
	| isMaster |
	isMaster := aMongoSDAMServerDescription isMaster.

	isMaster isSharded ifTrue: [ self shouldBeImplemented ].

	isMaster isReplicaSet ifFalse: [
		type := MongoTopologyType single.
		primaryUrlString := aMongoSDAMServerDescription urlString.
		^ self ].

	isMaster hasPrimary
		ifTrue: [
			type := MongoTopologyType replicaSetWithPrimary.
			primaryUrlString := isMaster primaryUrlString ]
		ifFalse: [ 
			type := MongoTopologyType replicaSetNoPrimary.
			primaryUrlString := nil ].

	secondaryUrlStrings := Array streamContents: [ :stream |
		| block |
		block := [ :each | each = primaryUrlString ifFalse: [ stream nextPut: each ] ].
		isMaster replicaSetHosts do: block.
		isMaster replicaSetPassives do: block. ].
