"
A mongo database

Instance Variables
	name:		<Object>
	root:		<Object>

name
	- xxxxx

root
	- xxxxx

"
Class {
	#name : #MongoDatabase,
	#superclass : #Object,
	#instVars : [
		'root',
		'name'
	],
	#category : #'Mongo-Core-Base'
}

{ #category : #'instance creation' }
MongoDatabase class >> root: aMongo name: aString [ 
	^self new
		setRoot: aMongo
		name: aString
]

{ #category : #operations }
MongoDatabase >> addCollection: aString [
	^ self
		addCollection: aString
		capped: false
		size: nil
		max: nil
]

{ #category : #private }
MongoDatabase >> addCollection: aString capped: aCapped size: aSize max: aMax [
	| command |
	command := OrderedIdentityDictionary new
					at: #create put: aString;
					yourself.
	aCapped ifTrue: [
		command at: #capped put: true.
		aSize ifNotNil: [command at: #size put: aSize].
		aMax ifNotNil: [command at: #max put: aMax]].
	[ self command: command ]
		on: MongoCommandError
		do: [ :error |
			"Tolerate error 48: collection already exists"
			error isCollectionAlreadyExists
				ifTrue: [ (MongoCollectionAlreadyExists new collectionName: aString) signal ]
				ifFalse: [ error signal ] ].
	^ self collectionAt: aString
]

{ #category : #accessing }
MongoDatabase >> collectionAt: aString [ 
	"Answers a MongoCollection for this database that has aString as name (may not exist)."

	^ MongoCollection database: self name: aString
]

{ #category : #operations }
MongoDatabase >> collectionNames [
	"Answer the names of the collections in this database.

	See more at https://docs.mongodb.com/manual/reference/command/listCollections/"

	| dictionary |
	dictionary := OrderedIdentityDictionary new
		at: #listCollections put: 1;
		at: #nameOnly put: true;
		yourself.

	^ (MongoCommandCursor
		database: self
		dictionary: dictionary)
		collect: [ :each | each at: 'name' ].
]

{ #category : #operations }
MongoDatabase >> collections [
	"Answer the collections in this database"

	^ self collectionNames collect: [ :each | self collectionAt: each ]
]

{ #category : #operations }
MongoDatabase >> command: anOrderedDictionary [
	^ root command: anOrderedDictionary database: self
]

{ #category : #operations }
MongoDatabase >> command: anOrderedDictionary flags: flags [

	^ root 
		command: anOrderedDictionary 
		database: self 
		flags: flags
]

{ #category : #operations }
MongoDatabase >> commandAndVerify: anOrderedDictionary [
	| res |
	res := root command: anOrderedDictionary database: self.
	res at: 'writeConcernError' ifPresent: [:err |
		MongoCommandError signalFor: err].
	res at: 'writeErrors' ifPresent: [:errors |
		MongoCommandError signalFor: errors last].
	^ res
]

{ #category : #operations }
MongoDatabase >> commandDelete: aDocument limit: aLimit collection: collectionName writeConcern: aConcern [

	^ self root
		commandDelete: aDocument
		limit: aLimit
		collection: collectionName
		writeConcern: aConcern
]

{ #category : #operations }
MongoDatabase >> commandFind: filterDictionary limit: aLimit collection: collectionName readConcern: aMongoReadConcern [
	"Answer a MongoCommandCursor that will perform a find using Mongo command.

	All parameters are optional (nil), except collectionName.

	See more on https://docs.mongodb.com/v4.0/reference/command/find/"

	| dict |
	dict := OrderedDictionary new.
	dict at: 'find' put: collectionName.
	filterDictionary ifNotNil: [
		dict at: 'filter' put: filterDictionary ].
	aLimit ifNotNil: [
		dict at: 'limit' put: aLimit ].
	aMongoReadConcern ifNotNil: [
		dict at: 'readConcern' put: aMongoReadConcern asConcernForCommand ].

	^ MongoCommandCursor database: self dictionary: dict
]

{ #category : #operations }
MongoDatabase >> commandInsert: newDictionary collection: aMongoCollection writeConcern: aConcern [
	"Insert using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/insert/"

	self root
		commandInsert: newDictionary
		collection: aMongoCollection
		writeConcern: aConcern
]

{ #category : #operations }
MongoDatabase >> commandUpdate: aDocument with: newDocument collection: aMongoCollection [

	^ self
		commandUpdate: aDocument
		with: newDocument
		collection: aMongoCollection
		writeConcern: nil
]

{ #category : #operations }
MongoDatabase >> commandUpdate: aDocument with: newDocument collection: aMongoCollection writeConcern: aConcern [

	^ self root
		commandUpdate: aDocument
		with: newDocument
		collection: aMongoCollection
		writeConcern: aConcern
]

{ #category : #operations }
MongoDatabase >> delete: aDictionary collection: aMongoCollection [

	root
		delete: aDictionary
		collection: aMongoCollection
]

{ #category : #actions }
MongoDatabase >> do: aBlock [
	"Performs aBlock and provides access to the database to 
	anyone calling CurrentMongoDatabase value."
	
	CurrentMongoDatabase
		value: self
		during: [ ^ aBlock value ]
]

{ #category : #operations }
MongoDatabase >> drop [
	self command: (OrderedIdentityDictionary new at: #dropDatabase put: 1.0; yourself)
]

{ #category : #operations }
MongoDatabase >> getCollection: aString [
	^ (self collectionAt: aString)
		ensureAdded;
		yourself
]

{ #category : #testing }
MongoDatabase >> hasCollectionNamed: aString [
	"Answers true if this database has a collection named aString"
	
	^ self collectionNames includes: aString
]

{ #category : #operations }
MongoDatabase >> insert: aDocument collection: aMongoCollection [

	root
		insert: aDocument
		collection: aMongoCollection
]

{ #category : #operations }
MongoDatabase >> isMaster [

	| reply |
	reply := self command: (OrderedDictionary new at: #ismaster put: 1; yourself).

	^ MongoIsMaster with: reply
]

{ #category : #operations }
MongoDatabase >> lastError [
	"Answer the result of getLastError mongodb command. 
	
	See more: https://docs.mongodb.com/manual/reference/command/getLastError
	"

	^ self lastError: nil
]

{ #category : #operations }
MongoDatabase >> lastError: aWriteConcernOrNil [
	"Answer the result of getLastError mongodb command. 
	
	See more: https://docs.mongodb.com/manual/reference/command/getLastError
	"

	| reply command |
	command := OrderedIdentityDictionary new 
		at: 'getLastError' put: 1; 
		yourself.
	aWriteConcernOrNil ifNotNil: [ aWriteConcernOrNil asKeysAndValuesInto: command ].
	reply := self command: command.
	
	^MongoLastError newFor: reply
]

{ #category : #operations }
MongoDatabase >> listCollections [
	"Answer the raw response of listCollections command.
	See more at https://docs.mongodb.com/manual/reference/command/listCollections/"

	^ self command: { #listCollections -> 1 } asDictionary
]

{ #category : #accessing }
MongoDatabase >> name [
	^name
]

{ #category : #factory }
MongoDatabase >> newQuery [

	^ root newQuery
		database: self;
		yourself
]

{ #category : #printing }
MongoDatabase >> printOn: aStream [

	aStream nextPutAll: name asString
]

{ #category : #accessing }
MongoDatabase >> qualifiedName [
	^self name
]

{ #category : #operations }
MongoDatabase >> query: aMongoQuery [
	
	aMongoQuery database: self.
	^ root query: aMongoQuery
]

{ #category : #operations }
MongoDatabase >> queryOne: aMongoQuery [
	aMongoQuery database: self.
	^root queryOne: aMongoQuery.
]

{ #category : #operations }
MongoDatabase >> replSetInitiate: configuration [
	"Answer the response of this command, that initializes a new replica set.

	See: https://docs.mongodb.com/v4.0/reference/command/replSetInitiate/"

	^ self command:
		(OrderedDictionary new
			at: 'replSetInitiate' put: configuration;
			yourself)
]

{ #category : #operations }
MongoDatabase >> replicaSetConfig [
	"Answer the configuration of the replica set.
	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetGetConfig/"

	| reply |
	reply := self command: (OrderedIdentityDictionary new at: #replSetGetConfig put: 1; yourself).

	^MongoReplicaSetConfig with: reply
]

{ #category : #operations }
MongoDatabase >> replicaSetStatus [
	"Answer the status of the replica set. Only works on 'admin' collection.
	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetGetStatus/"

	| reply |
	reply := self command: (OrderedIdentityDictionary new at: #replSetGetStatus put: 1; yourself).

	^MongoReplicaSetStatus with: reply
]

{ #category : #accessing }
MongoDatabase >> root [
	^root
]

{ #category : #private }
MongoDatabase >> setRoot: aMongo name: aString [ 
	root := aMongo.
	name := aString
]

{ #category : #operations }
MongoDatabase >> update: origDictionary with: newDictionary collection: aMongoCollection [

	root
		update: origDictionary
		with: newDictionary
		collection: aMongoCollection
]

{ #category : #operations }
MongoDatabase >> update: origDictionary with: newDictionary collection: aMongoCollection upsert: upsertBoolean multi: multiBoolean [

	root
		update: origDictionary
		with: newDictionary
		collection: aMongoCollection
		upsert: upsertBoolean
		multi: multiBoolean
]

{ #category : #operations }
MongoDatabase >> username: user password: password [
	^ root username: user password: password database: self
]
