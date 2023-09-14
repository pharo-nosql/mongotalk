Class {
	#name : #MongoTest,
	#superclass : #TestCase,
	#instVars : [
		'collection',
		'root',
		'database'
	],
	#category : #'Mongo-Tests-Core-Tests'
}

{ #category : #private }
MongoTest >> aWriteConcern [

	^ MongoWriteConcern new
		w: 1;
		j: false;
		wtimeout: 500;
		yourself
]

{ #category : #running }
MongoTest >> setUp [

	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
	collection := database getCollection: 'testCollection'
]

{ #category : #running }
MongoTest >> tearDown [

	database ifNotNil: [ database collections do: #drop ].
	root closeIfOpen.

	super tearDown
]

{ #category : #tests }
MongoTest >> testAdd [
	| data |

	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: (collection includes: data)
]

{ #category : #tests }
MongoTest >> testAddAll [
	| data |
	data := Array 
		with: (Dictionary new at: 'key' put: 'value'; yourself) 
		with: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection addAll: data.
	self assert: (collection includes: data first).
	self assert: (collection includes: data last)
]

{ #category : #tests }
MongoTest >> testAddArray [
	| data |
	data := Dictionary new at: 'key' put: #(3 1 2 44 5 432); yourself.
	collection add: data.
	self assert: (collection includes: data)
]

{ #category : #tests }
MongoTest >> testAddExistingCollection [

	self 
		should: [ database addCollection: 'testCollection' ]
		raise: MongoCollectionAlreadyExists.

]

{ #category : #tests }
MongoTest >> testCollectionEnsureAdded [
	collection := database collectionAt: 'collection'.
	self deny: (database collectionNames includes: 'collection').
	collection ensureAdded.
	self assert: (database collectionNames includes: 'collection').
	collection ensureAdded.
	self assert: (database collectionNames includes: 'collection').

]

{ #category : #tests }
MongoTest >> testCollectionValidation [
	self assert: collection validate isOK
]

{ #category : #tests }
MongoTest >> testCollections [
	| new |
	new := database addCollection: 'collection'.
	[self assert: (database collections contains: [:each | each name = 'collection'])]
		ensure: [new drop]
]

{ #category : #tests }
MongoTest >> testCursor [
	| count data query commandQuery |

	self assert: collection size equals: 0.
	data := Dictionary new at: 'key' put: 'value'; yourself.
	4 timesRepeat: [collection add: data].
	self assert: collection size equals: 4.
	count := 0.

	query := root driver newQuery
		database: database;
		collection: collection;
		where: data;
		doBlock: [:each | count := count + 1 ];
		chunkSize: 2;
		yourself.

	commandQuery := root driver newCommandQuery: query.
	commandQuery execute.

	self assert: count equals: 4
]

{ #category : #tests }
MongoTest >> testDatabaseCollectionNames [
	| names |

	names := database collectionNames.
	self assert: (names includes: 'testCollection').
	self deny: (names includes: 'testCollection42')
]

{ #category : #tests }
MongoTest >> testDatabaseHasCollectionNamed [

	self assert: (database hasCollectionNamed: 'testCollection').
	self deny: (database hasCollectionNamed: 'testCollection42')
]

{ #category : #tests }
MongoTest >> testDatabaseNames [

	self assert: (root databaseNames includes: 'test')
]

{ #category : #tests }
MongoTest >> testDatabases [

	self assert: (root databases contains: [:each | each name = 'test'])
]

{ #category : #tests }
MongoTest >> testDelete [
	| results data |

	data := (Dictionary new)
		at: 'key' put: 'value';
		yourself.
	collection add: data.
	collection delete: data.
	results := collection query: [ :query | ].

	self assert: results isEmpty
]

{ #category : #tests }
MongoTest >> testDo [
	| count |

	collection add: (Dictionary new at: 'key' put: 'value'; yourself).
	collection add: (Dictionary new at: 'key' put: 'value'; yourself).
	count := 0.
	collection do: [ :each |
		self assert: (each at: 'key') equals: 'value'.
		count := count + 1 ].
	self assert: count equals: 2
]

{ #category : #tests }
MongoTest >> testError [
	"induce an error and make sure an exception is thrown"
]

{ #category : #tests }
MongoTest >> testGetExistingCollection [
	| existing |
	existing := database getCollection: 'testCollection'.
	self assert: existing name = 'testCollection'
]

{ #category : #tests }
MongoTest >> testGetNoneExistingCollection [
	self deny: (database collectionNames includes: 'collection').
	database getCollection: 'collection'.
	self assert: (database collectionNames includes: 'collection').
]

{ #category : #tests }
MongoTest >> testInjectInto [
	collection add: (Dictionary new at: 'key' put: 2; yourself).
	collection add: (Dictionary new at: 'key' put: 3; yourself).
	self assert: (collection inject: 0 into: [:sum :each | sum + (each at: 'key')]) = 5
]

{ #category : #tests }
MongoTest >> testInsertAndQuery [
	| results |
	collection add: (Dictionary new at: 'key' put: 'value'; yourself).
	results := collection query: [ :query | ].
	self assert: results size equals: 1.
	self assert: (results first at: 'key') = 'value'
]

{ #category : #tests }
MongoTest >> testInsertAndQueryWithFields [
	| results |
	collection add: (Dictionary new 
		at: 'key' put: 'value'; 
		at: 'foo' put: 'bar'; 
		yourself).
	results := collection query: [ :query | 
		query
			where: Dictionary new;
			fields: (Dictionary new at: 'foo' put: 'bar'; yourself) ].
	self assert: results size = 1.
	self assert: (results first at: 'foo') = 'bar'.
	self deny: (results first includesKey: 'key')
]

{ #category : #tests }
MongoTest >> testInsertDuplicateError [
	| value wasInsertionError |
	value := { '_id' -> 1 } asDictionary.
	collection commandInsert: value writeConcern: nil.

	self
		should: [ 
			collection
				commandInsert: value
				writeConcern: nil ]
		raise: MongoCommandError
		withExceptionDo: [ :error |
			wasInsertionError := error isInsertionError ].

	self assert: wasInsertionError.
]

{ #category : #tests }
MongoTest >> testInsertTwoAndQuery [
	| results |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	self assert: collection size = 2.
	results := collection query: [ :query | ].
	self assert: results size = 2
]

{ #category : #tests }
MongoTest >> testInsertWithWriteConcern [
	| result new |

	new := { 'key' -> 'new value' } asDictionary.

	collection commandInsert: new writeConcern: self aWriteConcern.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'
]

{ #category : #tests }
MongoTest >> testInsertWithWriteConcernAndQuery [
	| results |
	collection 
		commandInsert: (Dictionary new at: 'key' put: 'value'; yourself) 
		writeConcern: self aWriteConcern.
	results := collection query: [ :query | ].
	self assert: results size equals: 1.
	self assert: (results first at: 'key') = 'value'
]

{ #category : #tests }
MongoTest >> testIsEmpty [
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	self assert: collection isEmpty.
	collection add: data.
	self deny: collection isEmpty
]

{ #category : #tests }
MongoTest >> testMajorVersion [

	self assert: root majorVersion isInteger
]

{ #category : #tests }
MongoTest >> testOccurrencesOf [
	| data |
	data := (Dictionary new)
				at: 'key1' put: 'value1';
				yourself.
	collection add: data.
	self assert: (collection occurrencesOf: data) equals: 1
]

{ #category : #tests }
MongoTest >> testOrderBy [
	| results query |
	collection add: (Dictionary new at: 'key' put: 'b'; yourself).
	collection add: (Dictionary new at: 'key' put: 'a'; yourself).
	collection add: (Dictionary new at: 'key' put: 'b'; yourself).

	query := root driver newQuery
		database: database;
		collection: collection;
		where: Dictionary new;
		order: { 'key' -> Mongo ascending} asDictionary.
	results := query perform.

	self assert: (results first at: 'key') equals: 'a'
]

{ #category : #tests }
MongoTest >> testRemove [
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: collection size = 1.
	collection remove: data.
	self assert: collection isEmpty
]

{ #category : #tests }
MongoTest >> testRemoveAll [
	| data |
	data := Array 
		with: (Dictionary new at: 'key' put: 'value'; yourself) 
		with: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection addAll: data.
	self assert: collection size = 2.
	collection removeAll: data.
	self assert: collection isEmpty
]

{ #category : #tests }
MongoTest >> testRemoveBoth [
	"Unlike regular collections, MongCollection>>remove: is more like copyWithout:,
	removing all instances of the offending element."

	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	collection add: data.
	self assert: collection size = 2.
	collection remove: data.
	self assert: collection isEmpty
]

{ #category : #tests }
MongoTest >> testRemoveMissingElementSucceeds [
	"Unlike Collection, MongoCollection succeeds if you try to remove a missing element.
	Hence there is no need for remove:ifAbsent:."
	collection add: ((Dictionary new)
				at: 'key1' put: 'value1';
				yourself).
	self assert: collection size = 1.
	collection remove: ((Dictionary new)
				at: 'key2' put: 'value2';
				yourself).
	self assert: collection size = 1 "No exception"
]

{ #category : #tests }
MongoTest >> testRemoveWithWriteConcern [
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: collection size = 1.
	collection commandDelete: data limit: 1 writeConcern: self aWriteConcern.
	self assert: collection isEmpty
]

{ #category : #tests }
MongoTest >> testSelect [
	| selected |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	selected := collection select: { 'key1' -> 'value1'} asDictionary.
	self assert: selected size equals: 1
]

{ #category : #tests }
MongoTest >> testSelectWithLimit [
	| selected query |

	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection add: (Dictionary new at: 'key3' put: 'value3'; yourself).

	query := root driver newQuery
		database: database;
		collection: collection;
		limit: 2.
	selected := query perform.

	self assert: selected size equals: 2
]

{ #category : #tests }
MongoTest >> testSelectWithLimitAndNumberToSkip [
	| firstBatch secondBatch |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection add: (Dictionary new at: 'key3' put: 'value3'; yourself).
	firstBatch := collection query: [ :query | query
		where: Dictionary new;
		limit: 2 ].
	secondBatch := collection query: [ :query | query
		where: Dictionary new;
		limit: 2;
		offset: 2 ].
	self assert: firstBatch size equals: 2.
	self assert: secondBatch size equals: 1.
	
]

{ #category : #tests }
MongoTest >> testUpdateWithUpsert [
	| result old new |

	old := { 'key' -> 'value' } asDictionary.
	new := { 'key' -> 'new value' } asDictionary.

	"Check that a normal update will not create anything"
	collection update: old with: new.
	result := collection query: [ :query | ].
	self assert: result size equals: 0.

	"Check that an upsert will create the record"
	collection update: old with: new upsert: true multi: false.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'.

	"And Go back"
	collection update: new with: old.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'value'.

	"And forward again"
	collection update: old with: new  upsert: true multi: false.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'
]

{ #category : #tests }
MongoTest >> testUpdateWithWriteConcern [
	| result old new |

	old := { 'key' -> 'value' } asDictionary.
	new := { 'key' -> 'new value' } asDictionary.

	collection add: old.
	collection commandUpdate: old with: new writeConcern: self aWriteConcern.
	result := collection query: [:query | ].
	self assert: result size equals: 1.
	self assert: (result first at: 'key') equals: 'new value'
]

{ #category : #tests }
MongoTest >> testVersion [

	self assert: root version isString
]
