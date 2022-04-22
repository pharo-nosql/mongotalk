"
Tests for Mongo Replica Set support with replica set available. 

"
Class {
	#name : #MongoReplicationOkTest,
	#superclass : #MongoReplicationTest,
	#instVars : [
		'database',
		'collection'
	],
	#category : 'Mongo-Tests-ReplicaSet'
}

{ #category : #running }
MongoReplicationOkTest >> defaultTimeLimit [
	^ 40 seconds
]

{ #category : #'instance creation' }
MongoReplicationOkTest >> newMongo [
	^ Mongo url: MongoReplicationTestResources mongoUrlA
]

{ #category : #tests }
MongoReplicationOkTest >> setUp [
	Transcript << self asString; << ' setUp '.
	MongoReplicationTestResources waitTestingScenario.

	super setUp.

	database := mongo databaseNamed: MongoReplicationTestResources databaseName.
	collection := database getCollection: 'testCollection'.

]

{ #category : #tests }
MongoReplicationOkTest >> tearDown [
	collection drop.
	super tearDown.
]

{ #category : #tests }
MongoReplicationOkTest >> testInsertWithWriteConcernError11000 [
	"Inserts two documents and verifies that inserting the second document
	violates a unique key constraint. Verify the document has NOT changed."

	| results concern |
	concern := MongoWriteConcern new w: 1; yourself.

	"Create an index with a unique key constraint."
	database command: ({
		'createIndexes' -> collection name.
		'indexes' -> {
			{	'key' -> { 'user_id' -> 1 } asDictionary.
				'unique' -> true.
				'name' -> 'unique_user_id'
			} as: OrderedDictionary }
		} as: OrderedDictionary).

	"Insert a valid value and assert it was added."
	collection
		commandInsert: { 'user_id' -> '1' } asDictionary
		writeConcern: concern.
	results := collection query: [ :query |  ].
	self assert: results size equals: 1.
	self assert: (results first at: 'user_id') equals: '1'.

	"Attempt to insert with a duplicate key"
	self
		should: [
			collection
				commandInsert:
					(Dictionary new
						at: 'user_id' put: '1';
						at: 'other' put: 3;
						yourself)
				writeConcern: concern ]
		raise: MongoCommandError
		withExceptionDo: [ :ex | 
			self assert: ex code equals: 11000.
			self assert: (ex errorMessage beginsWith: 
				'E11000 duplicate key error collection: ', collection qualifiedName) ].

	"Assert the insert was not performed"
	results := collection query: [ :query |  ].
	self assert: results size equals: 1.
	self deny: (results first includesKey: 'other')

]

{ #category : #tests }
MongoReplicationOkTest >> testIsMaster [

	| response |
	response := mongo isMaster.
	
	"Common API is short."
	self deny: response isNil.
	self deny: response isReadOnly.
	self assert: response isReplicaSet.
	self assert: response isMaster.
	
	"Replica Set specific API."
	self assert: response hasPrimary.
	self assert: response isPrimary.
	self deny: response isSecondary.
	self deny: response isPassive.
	self assert: response urlString equals: mongo host, ':', mongo port asString.
	self assert: response primaryUrlString equals: response urlString.
	self assert: response replicaSetHosts equals: #('localhost:27031' 'localhost:27032').
	self assert: response replicaSetPassives equals: #('localhost:27033').
	self assert: response lastWriteDateAndTime notNil.
	self assert: response staleness > 0 milliseconds.
]

{ #category : #tests }
MongoReplicationOkTest >> testRemoveWithWriteConcernError100 [
	"Removes an entry from the collection with an invalid write concern and
	verifies that an exception is raised. The document is still deleted from the
	collection."

	| data concern |
	concern := MongoWriteConcern new w: 50; yourself.
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: collection size equals: 1.

	self
		should: [ collection commandDelete: data limit: 1 writeConcern: concern ]
		raise: MongoCommandError
		withExceptionDo: [ :ex |
			self assert: ex code equals: 100.
			self assert: ex errorMessage equals: 'Not enough data-bearing nodes' ].

	self assert: collection isEmpty.
]

{ #category : #tests }
MongoReplicationOkTest >> testReplicaSetConfig [
	| replicaSet |
	replicaSet := mongo replicaSetConfig.

	self assert: replicaSet name isString.
	self deny: replicaSet members isEmpty.
	self assert: replicaSet members anyOne name isString.
	self assert: replicaSet members anyOne priority isNumber.
]

{ #category : #tests }
MongoReplicationOkTest >> testReplicaSetStatus [
	| replicaSetStatus |
	replicaSetStatus := mongo replicaSetStatus.

	self assert: replicaSetStatus name isString.
	self deny: replicaSetStatus members isEmpty.
	self assert: replicaSetStatus members anyOne host isString.
	self assert: replicaSetStatus members anyOne port isNumber.
	self deny: replicaSetStatus primaryMember isNil.

]

{ #category : #tests }
MongoReplicationOkTest >> testReplicaSetStepDown [

	"Step down the (prioritary) primary during some seconds"
	mongo replicaSetStepDown: 10 seconds.

	"It's still connected but it's not primary."
	self assert: mongo isOpen.
	
	"Then, it will signal an error on a write operation."
	[ 	self addNewCollection.
		self fail: 'should raise a `not master` error' ]
			on: MongoCommandError
			do: [ :error | 
				self assert: error isNotMaster ].

	"When the step down seconds passed, and the election finished, 
	the former primary server will be the primary again because it has more priority
	(see the replication scenario)."
	30 seconds wait.
	
	"It should be primary again, and complete the write operation without any error."
	self shouldnt: [ self addNewCollection ] raise: MongoCommandError.
]

{ #category : #tests }
MongoReplicationOkTest >> testUpdateWithWriteConcernError100 [
	"Attempts to update a document with an invalid write concern. Verify that this
	raises an exception (the actual effect on the collection will still happen)."

	| result old new concern |
	concern := MongoWriteConcern new
		w: 50;
		yourself.
	old := { 'key' -> 'value' } asDictionary.
	new := { 'key' -> 'new value' } asDictionary.
	collection add: old.

	self
		should: [ collection commandUpdate: old with: new writeConcern: concern ]
		raise: MongoCommandError
		withExceptionDo: [ :ex |
			self assert: ex code equals: 100.
			self assert: ex errorMessage equals: 'Not enough data-bearing nodes' ].

	result := collection query: [ :query |  ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'

]
