"
A legacy driver for mongo wire protocol (previous to v5.0) 
"
Class {
	#name : #MongoLegacyDriver,
	#superclass : #MongoDriver,
	#category : #'Mongo-DriverLegacy-Base'
}

{ #category : #accessing }
MongoLegacyDriver >> commandClass [

	^ self commandQueryClass
]

{ #category : #accessing }
MongoLegacyDriver >> commandQueryClass [

	^ MongoCursorLegacy
]

{ #category : #operations }
MongoLegacyDriver >> delete: aDocument collection: aMongoCollection [

	(DeleteOperation
		collection: aMongoCollection qualifiedName
			id: self nextRequestID
			stream: self stream
			query: aDocument)
		write
]

{ #category : #operations }
MongoLegacyDriver >> executeCommand: query [

	^ self queryOne: query
]

{ #category : #operations }
MongoLegacyDriver >> insert: aDocument collection: aMongoCollection [

	(InsertOperation
		collection: aMongoCollection qualifiedName
			id: self nextRequestID
			stream: self stream
			objects: aDocument)
		write
]

{ #category : #factory }
MongoLegacyDriver >> newQuery [

	^ super newQuery
		operation: QueryOperation;
		yourself
]

{ #category : #factory }
MongoLegacyDriver >> newQueryCommand: anOrderedDictionary database: aDatabase flags: flags [

	^ MongoQuery new
		operation: CommandOperation;
		database: aDatabase;
		collection: MongoCollection cmdVirtualCollection;
		where: anOrderedDictionary;
		flags: flags;
		yourself
]

{ #category : #operations }
MongoLegacyDriver >> query: aMongoQuery [
	| results |

	results := OrderedCollection new.
	aMongoQuery doBlock ifNil: [
		aMongoQuery doBlock: [:each | results add: each]].

	(self commandQueryClass
		root: self
		query: aMongoQuery)
		execute.

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

	self commandQueryClass new
		root: self;
		query: aMongoQuery;
		execute.

	^ nil
]
