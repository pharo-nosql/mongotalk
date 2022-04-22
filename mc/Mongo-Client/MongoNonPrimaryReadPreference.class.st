"
I represent read preference modes that are different than ""primary"". Such modes may have maxStaleness and tags parameters.

Extracted from documentation:

""The following are common use cases for using non-primary read preference modes:

    * Running systems operations that do not affect the front-end application.

    * Providing local reads for geographically distributed applications.
    If you have application servers in multiple data centers, you may consider having a geographically distributed replica set and using a non primary or nearest read preference. This allows the client to read from the lowest-latency members, rather than always reading from the primary.

    * Maintaining availability during a failover.
    Use primaryPreferred if you want an application to read from the primary under normal circumstances, but to allow stale reads from secondaries when the primary is unavailable. This provides a “read-only mode” for your application during a failover.""

Source: https://docs.mongodb.com/v4.0/core/read-preference/
"
Class {
	#name : #MongoNonPrimaryReadPreference,
	#superclass : #MongoReadPreference,
	#instVars : [
		'maxStaleness'
	],
	#category : 'Mongo-Client-ReadPreferences'
}

{ #category : #testing }
MongoNonPrimaryReadPreference >> hasMaxStalenessValue [
	^ maxStaleness notNil
]

{ #category : #accessing }
MongoNonPrimaryReadPreference >> maxStaleness [
	^ maxStaleness ifNil: [ self maxStalenessNullValue ]
]

{ #category : #accessing }
MongoNonPrimaryReadPreference >> maxStaleness: aDuration [
	"Replica set members can lag behind the primary due to network congestion, low disk throughput, long-running operations, etc. 
	The read preference maxStalenessSeconds option lets you specify a maximum replication lag, or “staleness”, for reads from secondaries. 
	When a secondary’s estimated staleness exceeds maxStalenessSeconds, the client stops using it for read operations.
	
	See: https://docs.mongodb.com/v4.0/core/read-preference/#replica-set-read-preference-max-staleness
	"

	maxStaleness := aDuration
]

{ #category : #accessing }
MongoNonPrimaryReadPreference >> maxStalenessNullValue [
	"Mongodb documentation defines this value as disabled maxStaleness."

	^ -1
]

{ #category : #printing }
MongoNonPrimaryReadPreference >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: '(maxStaleness: ';
		print: maxStaleness;
		nextPut: $).


]
