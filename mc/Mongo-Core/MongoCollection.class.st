"
A collection of mongo objects

Instance Variables
	database:		<Object>
	name:		<Object>

database
	- xxxxx

name
	- xxxxx

"
Class {
	#name : #MongoCollection,
	#superclass : #Object,
	#instVars : [
		'database',
		'name'
	],
	#category : #'Mongo-Core-Base'
}

{ #category : #convenience }
MongoCollection class >> cmdVirtualCollection [
	"Answer an object that represents '$cmd', a special virtual collection that
	exposes MongoDB’s database commands.
	
	See: https://docs.mongodb.com/v4.2/reference/glossary/#term-cmd
	"

	^ self database: nil name: '$cmd'

]

{ #category : #'instance creation' }
MongoCollection class >> database: aMongoDatabase name: aString [

	^self new
		setDatabase: aMongoDatabase
		name: aString
]

{ #category : #adding }
MongoCollection >> add: aDictionary [

	self insert: (Array with: aDictionary)
]

{ #category : #adding }
MongoCollection >> addAll: aCollection [ 
	self insert: aCollection
]

{ #category : #operations }
MongoCollection >> commandDelete: origDictionary limit: aLimit writeConcern: aConcern [
	"Delete using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/delete/"

	^database commandDelete: origDictionary limit: aLimit collection: name writeConcern: aConcern
]

{ #category : #operations }
MongoCollection >> commandFind: filterDictionary limit: aLimit readConcern: aMongoReadConcern [
	"Answer a MongoCommandCursor that will perform a find using Mongo command.

	All parameters are optional (nil).

	See more on https://docs.mongodb.com/v4.0/reference/command/find/"

	^ database
		commandFind: filterDictionary
		limit: aLimit
		collection: name
		readConcern: aMongoReadConcern
]

{ #category : #operations }
MongoCollection >> commandGetMore: cursorId batchSize: batchSizeOrNil timeout: aDurationOrNil [
	"Get a batch of documents from this collection using a cursor id obtained via commandFind* (for example).

	Translates to:
	
	{
	   'getMore': <long>,
	   'collection': <string>,
	   'batchSize': <int>,
	   'maxTimeMS': <int>
	}

	See: https://docs.mongodb.com/manual/reference/command/getMore/#dbcmd.getMore"

	| dictionary |
	dictionary := OrderedIdentityDictionary new
		at: #getMore put: cursorId;
		at: #collection put: name;
		yourself.

	batchSizeOrNil ifNotNil: [
		dictionary at: #batchSize put: batchSizeOrNil ].

	aDurationOrNil ifNotNil: [
		dictionary at: #maxTimeMS put: aDurationOrNil asMilliSeconds ].

	^ MongoQueryBatch newFromGetMoreResponse: (database command: dictionary)
]

{ #category : #operations }
MongoCollection >> commandInsert: newDictionary writeConcern: aConcern [
	"Insert using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/insert/"

	^database commandInsert: newDictionary collection: name writeConcern: aConcern
]

{ #category : #operations }
MongoCollection >> commandUpdate: origDictionary with: newDictionary [
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"

	^database commandUpdate: origDictionary with: newDictionary collection: name
]

{ #category : #operations }
MongoCollection >> commandUpdate: origDictionary with: newDictionary writeConcern: aConcern [
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"

	^ database
		commandUpdate: origDictionary
		with: newDictionary
		collection: name
		writeConcern: aConcern
]

{ #category : #accessing }
MongoCollection >> database [
	^database
]

{ #category : #operations }
MongoCollection >> delete: aDictionary [

	database
		delete: aDictionary
		collection: self
]

{ #category : #enumerating }
MongoCollection >> detect: aDictionary [
	^self queryOne: [ :query |
		query where: aDictionary ]
]

{ #category : #enumerating }
MongoCollection >> do: aBlock [
	^ self query: [ :query |
		query doBlock: aBlock ]
]

{ #category : #operations }
MongoCollection >> drop [
	| result |

	result := database command: (OrderedIdentityDictionary new
		at: #drop put: name;
		yourself).
	(result at: 'ok') = 1.0
		ifFalse: [ self error: 'I can''t drop the collection!' ]
]

{ #category : #convenience }
MongoCollection >> ensureAdded [
	[ database addCollection: name ]
		on: MongoCollectionAlreadyExists
		do: [ :error | ]
]

{ #category : #testing }
MongoCollection >> includes: aDictionary [
	"May be inefficient"
	^(self sizeForQuery: aDictionary) > 0
]

{ #category : #enumerating }
MongoCollection >> inject: anObject into: aBlock [
	| sum |
	sum := anObject.
	self do: [:each | sum := aBlock value: sum value: each].
	^sum
]

{ #category : #operations }
MongoCollection >> insert: aDocument [

	database
		insert: aDocument
		collection: self
]

{ #category : #testing }
MongoCollection >> isEmpty [
	^self size = 0
]

{ #category : #accessing }
MongoCollection >> name [
	^name
]

{ #category : #'private - factory' }
MongoCollection >> newQuery [
	
	^ self database newQuery
		collection: self;
		yourself
]

{ #category : #testing }
MongoCollection >> occurrencesOf: aDictionary [ 
	^(self select: aDictionary) size
]

{ #category : #private }
MongoCollection >> performQuery: aMongoQuery [

	^ database query: aMongoQuery
]

{ #category : #printing }
MongoCollection >> printOn: aStream [
	"Prints the receiver on a stream"
	
	aStream nextPutAll: name asString

]

{ #category : #accessing }
MongoCollection >> qualifiedName [

	^ database qualifiedName , '.' , name
]

{ #category : #queries }
MongoCollection >> query: aBlock [
	| query |

	query := self newQuery.
	aBlock value: query.
	 ^self performQuery: query
]

{ #category : #queries }
MongoCollection >> queryOne: aBlock [
	| query |
	query := self newQuery.
	aBlock value: query.
	^database queryOne: query
]

{ #category : #removing }
MongoCollection >> remove: aDictionary [

	database
		delete: aDictionary
		collection: self
]

{ #category : #removing }
MongoCollection >> removeAll: aCollection [
	"Worry about atomicity?"

	aCollection do: [:each | self remove: each]
]

{ #category : #adding }
MongoCollection >> replace: origDictionary with: newDictionary [
	self update: origDictionary with: newDictionary
]

{ #category : #enumerating }
MongoCollection >> select: aDictionary [
	^self query: [ :query |
		query where: aDictionary ]
]

{ #category : #enumerating }
MongoCollection >> select: aDictionary limit: limit offset: offset [
	^ self query: [:query |
		query
			where: aDictionary;
			limit: limit; 
			offset: offset ]
	
]

{ #category : #enumerating }
MongoCollection >> select: aDictionary limit: limit offset: offset order: orderDictionary [
	^ self query: [:query |
		query
			where: aDictionary;
			limit: limit; 
			offset: offset; 
			order: orderDictionary ]
	
]

{ #category : #enumerating }
MongoCollection >> select: aDictionary limit: limit offset: offset order: orderDictionary flags: flags [
	^ self query: [:query |
		query
			where: aDictionary;
			limit: limit; 
			offset: offset; 
			order: orderDictionary;
			flags: flags ]
	
]

{ #category : #private }
MongoCollection >> setDatabase: aMongoDatabase name: aString [

	database := aMongoDatabase.
	name := aString
]

{ #category : #accessing }
MongoCollection >> size [
	^self sizeForQuery: Dictionary new
]

{ #category : #operations }
MongoCollection >> sizeForQuery: aDictionary [
	"Answer the count the number of matching documents in this collection.

	See more on https://docs.mongodb.com/v4.0/reference/command/count/"

	| reply |
	reply := database
		command: (OrderedIdentityDictionary new
			at: #count put: name;
			at: #query put: aDictionary;
			yourself)
		flags: 0.

	^ (reply at: 'n') asInteger	"Why in the world is it a double?"
]

{ #category : #operations }
MongoCollection >> update: origDictionary with: newDictionary [

	database
		update: origDictionary
		with: newDictionary
		collection: self
]

{ #category : #operations }
MongoCollection >> update: origDictionary with: newDictionary upsert: upsertBoolean multi: multiBoolean [

	database
		update: origDictionary
		with: newDictionary
		collection: self
		upsert: upsertBoolean
		multi: multiBoolean
]

{ #category : #operations }
MongoCollection >> validate [
	| reply |
	reply := database command: (OrderedIdentityDictionary new at: #validate put: name; yourself).
	^CollectionValidation on: reply
]
