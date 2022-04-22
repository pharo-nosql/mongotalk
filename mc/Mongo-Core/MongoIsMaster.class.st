"
I represent the response of a ""isMaster"" command, defined by documentation in the following way:

isMaster returns a document that describes the role of the mongod instance. If the optional field saslSupportedMechs is specified, the command also returns an array of SASL mechanisms used to create the specified user’s credentials.

If the instance is a member of a replica set, then isMaster returns a subset of the replica set configuration and status including whether or not the instance is the primary of the replica set.

When sent to a mongod instance that is not a member of a replica set, isMaster returns a subset of this information.

MongoDB drivers and clients use isMaster to determine the state of the replica set members and to discover additional members of a replica set.


Read more at: https://docs.mongodb.com/v4.0/reference/command/isMaster/
"
Class {
	#name : #MongoIsMaster,
	#superclass : #Object,
	#instVars : [
		'response'
	],
	#category : 'Mongo-Core-Responses'
}

{ #category : #'instance creation' }
MongoIsMaster class >> with: aCollection [
	^ self basicNew
		initializeWith: aCollection;
		yourself
]

{ #category : #'accessing - diff' }
MongoIsMaster >> basicDifferencesFrom: anotherMongoIsMaster do: aBlockClosure [
	"Evaluate a block closure on each of the differences found between self and another IsMaster response (potentially from a different server in a replica set)."

	#(isWrittable isReplicaSet) do: [ :each | 
		| mine theirs |
		mine := self perform: each.
		theirs := anotherMongoIsMaster perform: each.
		mine = theirs ifFalse: [ aBlockClosure cull: each cull: theirs -> mine ] ]
]

{ #category : #'accessing - diff' }
MongoIsMaster >> differencesFrom: anotherMongoIsMaster do: aBlockClosure [
	"Evaluate a block closure on each of the differences found between self and another IsMaster response (potentially from a different server in a replica set)."

	self basicDifferencesFrom: anotherMongoIsMaster do: aBlockClosure.
	self isReplicaSet ifTrue: [
		self replicaSetDifferencesFrom: anotherMongoIsMaster do: aBlockClosure ].
]

{ #category : #'testing - common' }
MongoIsMaster >> hasDifferenceWith: anotherMongoIsMaster [
	self differencesFrom: anotherMongoIsMaster do: [ ^ true ].
	^ false
]

{ #category : #'replica set' }
MongoIsMaster >> hasPrimary [
	^ response includesKey: 'primary'
]

{ #category : #initialization }
MongoIsMaster >> initializeWith: aCollection [ 
	self initialize.
	
	response := aCollection.
]

{ #category : #accessing }
MongoIsMaster >> isMaster [
	"A boolean value that reports when this node is writable. If true, then this instance is a primary in a replica set, or a mongos instance, or a standalone mongod.

    This field will be false if the instance is a secondary member of a replica set or if the member is an arbiter of a replica set.

Source: https://docs.mongodb.com/manual/reference/command/isMaster/#isMaster.ismaster"

	^ response at: 'ismaster'
]

{ #category : #testing }
MongoIsMaster >> isPassive [
	^ response at: 'passive' ifAbsent: [ false ]
]

{ #category : #'replica set' }
MongoIsMaster >> isPrimary [
	^ self isMaster and: [ self isReplicaSet ]
]

{ #category : #accessing }
MongoIsMaster >> isReadOnly [
	^ response at: 'readOnly'
]

{ #category : #'replica set' }
MongoIsMaster >> isReplicaSet [
	^ response includesKey: 'setName'
]

{ #category : #'replica set' }
MongoIsMaster >> isSecondary [
	^ response at: 'secondary' ifAbsent: [ false ]
]

{ #category : #accessing }
MongoIsMaster >> isSharded [
	"Answer whether it's a sharded instance.

	See more at: 
	https://docs.mongodb.com/manual/reference/command/isMaster/#sharded-instances"
	
	^ response includesKey: 'msg'
]

{ #category : #accessing }
MongoIsMaster >> isWrittable [
	^ self isMaster
]

{ #category : #'accessing - replica set' }
MongoIsMaster >> lastWriteDateAndTime [
	^ ((response at: 'lastWrite') at: 'lastWriteDate') asDateAndTime 
]

{ #category : #accessing }
MongoIsMaster >> localTime [
	^ (response at: 'localTime') asDateAndTime
]

{ #category : #'replica set' }
MongoIsMaster >> primaryUrlString [
	^ response at: 'primary' ifAbsent: [ '' ]
]

{ #category : #'accessing - diff' }
MongoIsMaster >> replicaSetDifferencesFrom: anotherMongoIsMaster do: aBlockClosure [
	"Evaluate a block closure on each of the replica set differences between self and another IsMaster response (potentially from a different server in a replica set)."

	#(replicaSetHosts isSecondary hasPrimary primaryUrlString) do: [ :each | 
		| mine theirs |
		mine := self perform: each.
		theirs := anotherMongoIsMaster perform: each.
		mine = theirs ifFalse: [ aBlockClosure cull: each cull: theirs -> mine ] ]
]

{ #category : #'replica set' }
MongoIsMaster >> replicaSetHosts [
	^ response at: 'hosts'
]

{ #category : #'replica set' }
MongoIsMaster >> replicaSetName [
	^ response at: 'setName'
]

{ #category : #accessing }
MongoIsMaster >> replicaSetPassives [
	^ response at: 'passives' ifAbsent: [ #() ]
]

{ #category : #'replica set' }
MongoIsMaster >> replicaSetUrls [
	^ self replicaSetHosts collect: #asMongoUrl
]

{ #category : #'accessing - common' }
MongoIsMaster >> response [
	^ response
]

{ #category : #accessing }
MongoIsMaster >> staleness [
	"Answer the 'replication lag' of a non primary server.
	
	See: https://docs.mongodb.com/v4.0/core/read-preference/#maxstalenessseconds"

	^ self localTime - self lastWriteDateAndTime
]

{ #category : #'replica set' }
MongoIsMaster >> urlString [
	"In a replica set, this is the url of the requested server. Not defined else."
	
	^ response at: 'me'
]
