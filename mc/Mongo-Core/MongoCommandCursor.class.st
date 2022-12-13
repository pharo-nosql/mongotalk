"
Mongodb's provides find-like commands respond the first batch of a cursor. I help to enumerate documents in a database command reply with methods such as #contents, #do: and #collect:.

See: 
https://docs.mongodb.com/manual/reference/command/find/
https://docs.mongodb.com/manual/reference/command/listCollections/
https://docs.mongodb.com/manual/reference/command/getMore/#dbcmd.getMore

"
Class {
	#name : #MongoCommandCursor,
	#superclass : #Object,
	#instVars : [
		'database',
		'batch',
		'command',
		'batchSizeOrNil',
		'timeoutOrNil',
		'flags'
	],
	#category : #'Mongo-Core-Utilities'
}

{ #category : #'instance creation' }
MongoCommandCursor class >> database: aMongoDatabase dictionary: aCollection [ 
	^ self basicNew
		initializeDatabase: aMongoDatabase
		command: aCollection;
		yourself.

]

{ #category : #accessing }
MongoCommandCursor >> batchSizeOrNil [
	^ batchSizeOrNil
]

{ #category : #accessing }
MongoCommandCursor >> batchSizeOrNil: anObject [
	batchSizeOrNil := anObject
]

{ #category : #enumerating }
MongoCommandCursor >> collect: aBlockClosure [ 
	^ Array streamContents: [ :stream |
		self do: [ :each | stream nextPut: (aBlockClosure value: each) ] ]

]

{ #category : #accessing }
MongoCommandCursor >> command [
	^ command
]

{ #category : #enumerating }
MongoCommandCursor >> contents [
	^ self collect: #yourself
]

{ #category : #accessing }
MongoCommandCursor >> database [
	^ database
]

{ #category : #enumerating }
MongoCommandCursor >> do: aBlockClosure [ 
	batch := self firstBatch.

	[	batch documents do: aBlockClosure.
		batch atEnd ifTrue: [ ^self ].
		batch := (database collectionAt: batch collectionName) commandGetMore: batch cursorId batchSize: self batchSizeOrNil timeout: self timeoutOrNil
		] repeat
]

{ #category : #enumerating }
MongoCommandCursor >> firstBatch [

	^ MongoQueryBatch newFromFirstBatchResponse: (database 
		command: command 
		flags: self flags)
]

{ #category : #accessing }
MongoCommandCursor >> flags [
	^ flags ifNil: [ 0 ]
]

{ #category : #accessing }
MongoCommandCursor >> flags: flagsAsInteger [
	"Query operation flags. See QueryOperation class side."
	
	flags := flagsAsInteger
]

{ #category : #initialization }
MongoCommandCursor >> initializeDatabase: aMongoDatabase command: aCollection [ 
	self initialize.
	
	database := aMongoDatabase.
	command := aCollection.
]

{ #category : #convenience }
MongoCommandCursor >> setFlagSlaveOk [
	self flags: self flags | QueryOperation flagSlaveOk
]

{ #category : #accessing }
MongoCommandCursor >> timeoutOrNil [
	^ timeoutOrNil
]

{ #category : #accessing }
MongoCommandCursor >> timeoutOrNil: aDuration [
	timeoutOrNil := aDuration
]