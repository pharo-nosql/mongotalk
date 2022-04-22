"
Tests for Mongo Replica Set support. My subclasses represent basic scenarios.
"
Class {
	#name : #MongoReplicationTest,
	#superclass : #TestCase,
	#instVars : [
		'mongo'
	],
	#category : 'Mongo-Tests-ReplicaSet'
}

{ #category : #running }
MongoReplicationTest >> addNewCollection [
	(mongo databaseNamed: MongoReplicationTestResources databaseName)
		addCollection: 'testReplicaSetStepDown', UUID new asString36
]

{ #category : #'instance creation' }
MongoReplicationTest >> newMongo [
	self subclassResponsibility
]

{ #category : #running }
MongoReplicationTest >> setUp [
	super setUp.
	
	mongo := self newMongo.
	mongo open.
]

{ #category : #running }
MongoReplicationTest >> tearDown [
	super tearDown.
	mongo ifNotNil: [ mongo closeIfOpen ].
]
