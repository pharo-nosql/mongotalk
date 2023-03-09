"
A legacy driver for mongo wire protocol (previous to v5.0) 
"
Class {
	#name : #MongoLegacyDriver,
	#superclass : #MongoDriver,
	#category : #'Mongo-DriverLegacy-Base'
}

{ #category : #operations }
MongoLegacyDriver >> executeCommand: query [

	^ self queryOne: query
]

{ #category : #operations }
MongoLegacyDriver >> insert: aDocument inCollection: aMongoCollection inDatabase: aMongoDatabase [


	(InsertOperation
		collection: aMongoCollection qualifiedName
			id: self root nextRequestID
			stream: self root stream
			objects: aDocument)
		write
]

{ #category : #factory }
MongoLegacyDriver >> newCommand: anOrderedDictionary database: aDatabase flags: flags [

	^ MongoQuery new
		operation: CommandOperation;
		database: aDatabase;
		collection: MongoCollection cmdVirtualCollection;
		where: anOrderedDictionary;
		flags: flags;
		yourself
]

{ #category : #factory }
MongoLegacyDriver >> newQuery [

	^ super newQuery
		operation: QueryOperation;
		yourself
]

{ #category : #operations }
MongoLegacyDriver >> query: aMongoQuery [
	| results |

	results := OrderedCollection new.
	aMongoQuery doBlock ifNil: [
		aMongoQuery doBlock: [:each | results add: each]].

	(MongoCursor root: self query: aMongoQuery) execute.

	(results isNotEmpty and: [ results first includesKey: '$err' ])
		ifTrue: [ ^ MongoQueryError signalFor: results first ].

	^ results
]

{ #category : #operations }
MongoLegacyDriver >> queryOne: aMongoQuery [

	aMongoQuery doBlock: [:each |
		^ (each includesKey: '$err')
			ifTrue: [ MongoQueryError signalFor: each ]
			ifFalse: [ each ] ].

	aMongoQuery chunkSize: 1.

	MongoCursor new
		root: self;
		query: aMongoQuery;
		execute.

	^ nil
]
