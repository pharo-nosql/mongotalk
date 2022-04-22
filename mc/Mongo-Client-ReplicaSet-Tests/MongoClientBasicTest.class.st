Class {
	#name : #MongoClientBasicTest,
	#superclass : #MongoClientReplicaSetTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #tests }
MongoClientBasicTest >> testDefaultGlobalReadPreference [
	client := MongoClient
		withUrls: {MongoReplicationTestResources mongoUrlA}.
	self
		assert: client settings readPreference class
		equals: MongoPrimaryReadPreference
]

{ #category : #tests }
MongoClientBasicTest >> testInitialTopologyIsUnknown [

	client := self newClient.
	self assert: client topology isTypeUnknown.
	client start.
	self assert: client topology isTypeUnknown.
	10 milliSeconds wait.
	self deny: client topology isTypeUnknown.

]

{ #category : #tests }
MongoClientBasicTest >> testInstanceCreation [
	"MongoDB specs explicits that clients shouldn't try to connect on instance creation."
	
	| count |
	count := SocketStream allInstances size.
	self
		should: [
			client := MongoClient withUrls: { MongoTestResources mongoUrlOffline } ]
		notTakeMoreThan: 100 milliSeconds.

	self assert: SocketStream allInstances size equals: count.
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.

]

{ #category : #tests }
MongoClientBasicTest >> testStopAndRestart [
	
	client := self newClient.
	self startClientAndWait.
	self assert: client isStarted.

	client stop.
	1 second wait.
	self deny: client isStarted.

	self startClientAndWait.
	self assert: client isStarted.

]
