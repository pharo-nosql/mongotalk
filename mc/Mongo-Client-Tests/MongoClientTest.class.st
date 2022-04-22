Class {
	#name : #MongoClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client'
	],
	#category : 'Mongo-Client-Tests'
}

{ #category : #tests }
MongoClientTest >> collectionNameForTesting [
	^ 'testCollection'
]

{ #category : #running }
MongoClientTest >> commandReadOn: collection [
	^ (collection
			commandFind: (Dictionary new at: 'key1' put: 'value1'; yourself)
			limit: 0
			readConcern: MongoReadConcern available)
			setFlagSlaveOk;
			contents
]

{ #category : #running }
MongoClientTest >> commandWriteOn: collection [
	collection 
		commandInsert: (Dictionary new at: 'key1' put: 'value1'; yourself) 
		writeConcern: nil
]

{ #category : #accessing }
MongoClientTest >> defaultTimeLimit [
	^ 3 minutes
]

{ #category : #running }
MongoClientTest >> newClient [
	client := MongoClient withUrls: self urlsToTest.
	client settings
		connectTimeout: 5 seconds;
		socketTimeout: 5 seconds;
		heartbeatFrequency: 3 seconds.
	^ client
]

{ #category : #running }
MongoClientTest >> startClientAndWait [
	client start.
	1 second wait
]

{ #category : #running }
MongoClientTest >> tearDown [
	super tearDown.

	client ifNotNil: [ client stop ]
]

{ #category : #running }
MongoClientTest >> urlsToTest [
	^ self subclassResponsibility
]

{ #category : #running }
MongoClientTest >> waitMonitorsHeartbeatAndTimeout [
	60 seconds wait
]

{ #category : #running }
MongoClientTest >> wireProtocolReadOn: collection [
	^ collection
		select: { 'key1' -> 'value1' } asDictionary
		limit: 0
		offset: 0
		order: Dictionary new
		flags: QueryOperation flagSlaveOk
]

{ #category : #running }
MongoClientTest >> wireProtocolWriteOn: collection [
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself)
]
