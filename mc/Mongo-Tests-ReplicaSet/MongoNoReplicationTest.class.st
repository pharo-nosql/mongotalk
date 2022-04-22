"
Tests for Mongo Replica Set support with replica set *NOT* available. 

My tests assume that `Mongo default` has no replication set.
"
Class {
	#name : #MongoNoReplicationTest,
	#superclass : #MongoReplicationTest,
	#category : 'Mongo-Tests-ReplicaSet'
}

{ #category : #'instance creation' }
MongoNoReplicationTest >> newMongo [
	"Note: This assumes that Mongo default has no replication set."

	^Mongo default
]

{ #category : #tests }
MongoNoReplicationTest >> shouldSignalNotRunningWithReplSet: aBlock [

	aBlock
		on: MongoCommandError
		do: [ :error | 
			self assert: error isNotRunningWithReplSet.
			^ self ].
	self fail: 'mongodb should signal `not running with --replSet`'
]

{ #category : #tests }
MongoNoReplicationTest >> testIsMaster [

	| response |
	response := mongo isMaster.
	
	"Common API is short."
	self assert: response isMaster.
	self deny: response isNil.
	self deny: response isReadOnly.
	self deny: response isReplicaSet.
	
	"Replica Set API that works, anyway."
	self deny: response hasPrimary.
	self deny: response isPrimary.
	self deny: response isSecondary.

]

{ #category : #tests }
MongoNoReplicationTest >> testReplicaSetConfig [
	"Note: This assumes that Mongo default has no replication set."

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSetConfig ]
]

{ #category : #tests }
MongoNoReplicationTest >> testReplicaSetStatus [
	"Note: This assumes that Mongo default has no replication set."

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSetStatus ]
]

{ #category : #tests }
MongoNoReplicationTest >> testReplicaSetStepDown [
	"Note: This test case assumes that Mongo default has no replication set."

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSetStepDown: 10 seconds ]
]
