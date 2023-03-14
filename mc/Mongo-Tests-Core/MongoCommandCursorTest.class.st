Class {
	#name : #MongoCommandCursorTest,
	#superclass : #TestCase,
	#instVars : [
		'collection',
		'root',
		'database',
		'documents'
	],
	#category : #'Mongo-Tests-Core-Tests'
}

{ #category : #tests }
MongoCommandCursorTest >> assertExpectedDocuments: aCollection [
	self assert: aCollection size equals: self expectedDocumentCount.

	aCollection doWithIndex: [ :each :index |
		self baseDocumentForTesting keysAndValuesDo: [ :key :value |
			self assert: (each at: key) equals: value ].
		self assert: (each at: 'index') equals: index ].

]

{ #category : #running }
MongoCommandCursorTest >> baseDocumentForTesting [
	^ OrderedDictionary new
		at: 'type' put: 'test';
		yourself
]

{ #category : #tests }
MongoCommandCursorTest >> commandForTesting [
	^ OrderedDictionary new
		at: 'find' put: collection name;
		at: 'filter' put: self baseDocumentForTesting;
		yourself
]

{ #category : #running }
MongoCommandCursorTest >> expectedDocumentCount [
	^ 1000
]

{ #category : #running }
MongoCommandCursorTest >> setUp [
	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
	collection := database getCollection: 'testCollection'.

	documents := (1 to: self expectedDocumentCount) collect: [:index |
		self baseDocumentForTesting
			at: 'index' put: index;
			yourself ].
	documents do: [ :each | collection add: each ].
]

{ #category : #running }
MongoCommandCursorTest >> tearDown [
	database collections do: #drop.
	root close.
]

{ #category : #tests }
MongoCommandCursorTest >> testCollect [
	| cursor collected |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	
	collected := cursor collect: [ :each | each ].
	self assertExpectedDocuments: collected.

]

{ #category : #tests }
MongoCommandCursorTest >> testCollectionFindWithFilter [
	| commandCursor |

	commandCursor := collection
		commandFind: (Dictionary new at: 'index' put: 3; yourself)
		limit: nil
		readConcern: nil.

	self assert: commandCursor contents size equals: 1
]

{ #category : #tests }
MongoCommandCursorTest >> testCollectionFindWithReadConcernLocal [
	| commandCursor |
	commandCursor := collection
		commandFind: nil
		limit: nil
		readConcern: MongoReadConcern local.

	self assert: commandCursor contents size equals: 1000.

]

{ #category : #tests }
MongoCommandCursorTest >> testCollectionFindWithoutFilterWithLimit [
	| commandCursor |
	commandCursor := collection
		commandFind: nil
		limit: 10
		readConcern: nil.

	self assert: commandCursor contents size equals: 10.

]

{ #category : #tests }
MongoCommandCursorTest >> testContents [
	| cursor |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	
	self assertExpectedDocuments: cursor contents.

]

{ #category : #tests }
MongoCommandCursorTest >> testDo [
	| cursor collected |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	
	collected := OrderedCollection new.
	cursor do: [ :each | collected add: each ].
	self assertExpectedDocuments: collected.

]

{ #category : #tests }
MongoCommandCursorTest >> testSpecifyingBatchSize [
	| cursor |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	cursor batchSizeOrNil: 10.
		
	self assertExpectedDocuments: cursor contents.

]

{ #category : #tests }
MongoCommandCursorTest >> testSpecifyingTimeoutSignalsError [
	| cursor |
	cursor := MongoCommandCursor
		database: database
		dictionary: self commandForTesting.
	cursor timeoutOrNil: 1000 milliSeconds.
	self
		should: [ cursor contents ]
		raise: MongoCommandError
		whoseDescriptionIncludes: 'cannot set maxTimeMS on getMore command for a non-awaitData cursor'
		description: 'This is the expected behavior in Mongo (4).'
]
