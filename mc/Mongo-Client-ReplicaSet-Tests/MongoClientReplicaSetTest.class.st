Class {
	#name : #MongoClientReplicaSetTest,
	#superclass : #MongoClientTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #running }
MongoClientReplicaSetTest >> setUp [
	super setUp.

	Transcript << self asString; << ' setUp '.
	MongoReplicationTestResources waitTestingScenario.
]

{ #category : #running }
MongoClientReplicaSetTest >> stopAllExceptC [
	"Stop possible primaries (and don't wait until client realizes of it)."

	MongoReplicationTestResources
		signalStopA;
		signalStopB.

]

{ #category : #running }
MongoClientReplicaSetTest >> stopAllExceptCAndWait [
	"Then stop all but C (the that cannot be primary), and wait until monitors realize."

	self stopAllExceptC.
	self waitMonitorsHeartbeatAndTimeout.
]

{ #category : #running }
MongoClientReplicaSetTest >> urlsToTest [
	^ MongoReplicationTestResources allMongoUrls
]
