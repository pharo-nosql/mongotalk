Class {
	#name : 'MongoDriverC',
	#superclass : 'MongoDriver',
	#instVars : [
		'mongoc',
		'bson',
		'client',
		'collections'
	],
	#category : 'Mongo-DriverC-Base',
	#package : 'Mongo-DriverC',
	#tag : 'Base'
}

{ #category : 'private - accessing' }
MongoDriverC >> bson [

	^ bson
]

{ #category : 'private' }
MongoDriverC >> bsonToJson: aBson [
	| data internalData |

	data := bson get_data: aBson.
	internalData := ByteArray new: aBson len.
	LibC memCopy: data to: internalData size: internalData size.
	^ BSON read: internalData readStream
]

{ #category : 'private' }
MongoDriverC >> collectionFor: aMongoCollection [

	^ collections 
		at: aMongoCollection name 
		ifAbsentPut: [ 
			self 
				retrieveMongoCollectionDatabase: aMongoCollection database name
				name: aMongoCollection name ]
]

{ #category : 'operations' }
MongoDriverC >> commandCreateIndexName: aName keys: keyAssociations unique: aBoolean collection: aMongoCollection [
	"Create index using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/
	
	keyAssociations is a collection of associations where 
		key = field name to index
		value = 1 - ascending. -1 descending"
	| result keys options model models error |

	keys := self jsonToBson: keyAssociations asOrderedDictionary.
	options := self jsonToBson: { 'unique' -> aBoolean } asOrderedDictionary.
	
	model := mongoc 
		index_model_newKeys: keys getHandle
		opts: options getHandle.
	models := FFIArray newType: McIndexModelT size: 1.
	models at: 1 put: model.
	error := BsonErrorT new.
	
	[
		result := mongoc 
			collection_create_indexes_with_optsCollection: (self collectionFor: aMongoCollection)  
			models: models
			n_models: 1
			opts: BsonT null getHandle
			reply: BsonT null getHandle 
			error: error referenceTo getHandle.
		result = 1 ifFalse: [ 
			MongoCCommandError signalFor: error ] ] 
	ensure: [
		mongoc index_model_destroy: model.
 		bson destroy: keys.
 		bson destroy: options ]
]

{ #category : 'operations' }
MongoDriverC >> commandInsert: aDocument collection: aMongoCollection writeConcern: aConcern [
	
	self 
		insertOne: aDocument 
		collection: aMongoCollection 
		writeConcern: aConcern
]

{ #category : 'accessing' }
MongoDriverC >> commandQueryClass [

	^ MongoCCursorQuery
]

{ #category : 'private' }
MongoDriverC >> cursorQuery: aMongoQuery [
	"This message returns an open cursor used to traverse the collection."
	| filter data cursor opts |

	filter := self jsonToBson: aMongoQuery where.
	opts := aMongoQuery asOptionsDocument 
		ifNotEmpty: [ :optionsDocument | self jsonToBson: optionsDocument ]
		ifEmpty: [ BsonT null ].
	
	[ 
		cursor := self mongoc 
			collection_find_with_optsCollection: (self collectionFor: aMongoQuery collection)
			filter: filter getHandle
			opts: opts getHandle
			read_prefs: ExternalAddress null ]
	ensure: [
 		bson destroy: filter.
 		opts isNullOrNil 
 			ifFalse: [ bson destroy: opts ] ].
 			
 	^ cursor
]

{ #category : 'operations' }
MongoDriverC >> delete: aDocument collection: aMongoCollection [
	
	^ self deleteMany: aDocument collection: aMongoCollection
]

{ #category : 'operations' }
MongoDriverC >> deleteMany: aDocument collection: aMongoCollection [
	| doc result reply error replyJson deletedCount |

	deletedCount := 0.
	doc := self jsonToBson: aDocument.
	reply := BsonT new.
	error :=  BsonErrorT new.
	result := 0.
	[ 
		result := mongoc 
			collection_delete_manyCollection: (self collectionFor: aMongoCollection)
			selector: doc getHandle
			opts: BsonT null getHandle
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.
		result = 1
			ifTrue: [
				replyJson := self bsonToJson: reply.
				deletedCount := replyJson at: 'deletedCount' ]
			ifFalse: [ 
				MongoCCommandError signalFor: error ] ] 
	ensure: [
 		bson destroy: doc.
 		((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 
 	^ deletedCount
]

{ #category : 'operations' }
MongoDriverC >> deleteOne: aDocument collection: aMongoCollection [
	| doc result reply error replyJson deletedCount |

	deletedCount := 0.
	doc := self jsonToBson: aDocument.
	reply := BsonT new.
	error :=  BsonErrorT new.
	result := 0.
	[ 
		result := mongoc 
			collection_delete_oneCollection: (self collectionFor: aMongoCollection)
			selector: doc getHandle
			opts: BsonT null getHandle
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.
		result = 1
			ifTrue: [
				replyJson := self bsonToJson: reply.
				deletedCount := replyJson at: 'deletedCount' ]
			ifFalse: [ 
				MongoCCommandError signalFor: error ] ] 
	ensure: [
 		bson destroy: doc.
 		((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 
 	^ deletedCount
]

{ #category : 'private' }
MongoDriverC >> destroyClient [

	client isNullOrNil ifTrue: [ ^ self ].
	
	self mongoc client_destroy: client.
	client := nil
]

{ #category : 'private' }
MongoDriverC >> destroyCollections [

	client isNullOrNil ifTrue: [ ^ self ].
	
	collections 
		reject: [ :each | each isNullOrNil ]
		thenDo: [ :each | 
			self mongoc collection_destroy: each.
			each getHandle beNull ]
]

{ #category : 'operations' }
MongoDriverC >> executeCommand: aCommand [
	| doc result reply error resultJson |

	doc := self jsonToBson: aCommand where.
	reply := BsonT new.
	error :=  BsonErrorT new.
	result := 0.
	[ 
		result := self mongoc
			client_command_simpleClient: client
			db_name: aCommand database name
			command: doc getHandle
			read_prefs: ExternalAddress null
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.
		result = 1
			ifTrue: [ 
				resultJson := self bsonToJson: reply ]
			ifFalse: [
				MongoCCommandError signalFor: error ] ]
	ensure: [
 		bson destroy: doc.
 		((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 			
 	^ resultJson
]

{ #category : 'finalization' }
MongoDriverC >> finalize [

	self destroyCollections.
	self destroyClient
]

{ #category : 'private' }
MongoDriverC >> forEachDocumentInCursor: cursor do: aBlock [
	| docHandle doc |

	docHandle := FFIOop newValueHolder.
	[ (self mongoc cursor_nextCursor: cursor bson: docHandle) = 1 ]
	whileTrue: [
		doc := BsonT fromHandle: docHandle value.
		aBlock value: (self bsonToJson: doc) ]
]

{ #category : 'initialization' }
MongoDriverC >> initialize [

	super initialize.

	"just easy accessors"
	mongoc := LibMongoc uniqueInstance.
	bson := LibBson uniqueInstance.
	
	"register for finalisation, as clients can remain around"
	FinalizationRegistry default add: self.

	"ensure init"
	mongoc init.

	"mongo collections container"
	collections := Dictionary new
]

{ #category : 'operations' }
MongoDriverC >> insert: anArray collection: aMongoCollection [

	^ self 
		insert: anArray 
		collection: aMongoCollection 
		writeConcern: nil
]

{ #category : 'operations' }
MongoDriverC >> insert: anArray collection: aMongoCollection writeConcern: aWriteConcern [

	^ anArray size = 1 
		ifTrue: [ 
			self 
				insertOne: anArray first 
				collection: aMongoCollection 
				writeConcern: aWriteConcern ]
		ifFalse: [ 
			self 
				insertMany: anArray 
				collection: aMongoCollection 
				writeConcern: aWriteConcern ]
]

{ #category : 'operations' }
MongoDriverC >> insertMany: aCollection collection: aMongoCollection writeConcern: aWriteConcern [
	| docs result reply error replyJson insertedCount docHandles opts writeConcern |

	insertedCount := 0.
	self flag: #TODO. "This deserves an optimisation, I think"
	docHandles := FFIArray newType: FFIOop size: aCollection size.
	docs := aCollection withIndexCollect: [ :each :index | 
		| doc |
		doc := self jsonToBson: each.
		docHandles at: index put: doc getHandle.
		doc ].
	
	opts := BsonT null.
	aWriteConcern ifNotNil: [ 
		writeConcern := self writeConcernToMongo: aWriteConcern.
		opts := bson new.
		mongoc write_concern_appendWrite_concern: writeConcern doc: opts getHandle ].
	
	reply := BsonT new.
	error :=  BsonErrorT new.
	result := 0.
	[ 
		result := self mongoc 
			collection_insert_manyCollection: (self collectionFor: aMongoCollection)
			documents: docHandles
			n_documents: docs size
			opts: opts getHandle
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.
		result = 1
			ifTrue: [
				replyJson := self bsonToJson: reply.
				insertedCount := replyJson at: 'insertedCount' ]
			ifFalse: [ 
				MongoCCommandError signalFor: error ] ] 
	ensure: [
		docs do: [ :each |
 			bson destroy: each ].
 				((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 
 	^ insertedCount
]

{ #category : 'operations' }
MongoDriverC >> insertOne: aDocument collection: aMongoCollection writeConcern: aWriteConcern [
	| doc result reply error replyJson insertedId opts writeConcern |

	insertedId := nil.
	doc := self jsonToBson: aDocument.
	reply := BsonT new.
	error :=  BsonErrorT new.
	result := 0.
	
	opts := BsonT null.
	aWriteConcern ifNotNil: [ 
		writeConcern := self writeConcernToMongo: aWriteConcern.
		opts := bson new.
		mongoc write_concern_appendWrite_concern: writeConcern doc: opts getHandle ].
	
	[ 
		result := self mongoc 
			collection_insert_oneCollection: (self collectionFor: aMongoCollection)
			document: doc getHandle
			opts: opts getHandle
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.
		result = 1
			ifTrue: [
				replyJson := self bsonToJson: reply.
				insertedId := replyJson at: 'insertedId' ]
			ifFalse: [ 
				MongoCCommandError signalFor: error ] ] 
	ensure: [
 		bson destroy: doc.
 		opts isNullOrNil 
 			ifFalse: [ bson destroy: opts ].
 		writeConcern isNullOrNil
 			ifFalse: [ mongoc write_concern_destroy: writeConcern ].
 		((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 
 	^ insertedId
]

{ #category : 'testing' }
MongoDriverC >> isOpen [

	^ false
]

{ #category : 'private' }
MongoDriverC >> jsonToBson: aDictionary [
	| data |

	data := BSON write: aDictionary.
	^ self bson 
		new_from_data: data
		length: data size
]

{ #category : 'private - accessing' }
MongoDriverC >> mongoc [

	^ mongoc
]

{ #category : 'private - factory' }
MongoDriverC >> newCommandQuery: aQuery [
	"This is in fact a very bad name. It should be newCursorCommandForQuery: or 
	 something like this. 
	 I am here carrying the burden of bad old decisions :("

	^ self commandQueryClass
		root: self
		query: aQuery
]

{ #category : 'factory' }
MongoDriverC >> newQueryCommand: anOrderedDictionary database: aDatabase flags: flags [

	^ MongoQuery new
		operation: OpMsgCommand;
		database: aDatabase;
		where: anOrderedDictionary;
		flags: flags;
		yourself
]

{ #category : 'accessing' }
MongoDriverC >> openFor: aMongo [

	self destroyClient.

	client := self mongoc client_new: ('mongodb://{1}:{2}' 
		format: { 
			aMongo host. 
			aMongo port })	
]

{ #category : 'operations' }
MongoDriverC >> query: aMongoQuery [
	"gets a cursor query and iterates it to retrieve a list of documents" 
	| results cursor |

	[ 
		cursor := self cursorQuery: aMongoQuery.
		results := OrderedCollection new.
		self 
			forEachDocumentInCursor: cursor 
			do: [ :each | results add: each ] ]
	ensure: [
		cursor isNullOrNil 
			ifFalse: [ mongoc cursor_destroy: cursor ] ].
 			
 	^ results
]

{ #category : 'private' }
MongoDriverC >> retrieveMongoCollectionDatabase: dbName name: aName [

	^ self mongoc
		client_get_collectionClient: client 
		db: dbName
		collection: aName
]

{ #category : 'operations' }
MongoDriverC >> update: aDocument with: newDocument collection: aMongoCollection upsert: upsertBoolean multi: multiBoolean [

	^ multiBoolean
		ifTrue: [ 
			self 
				updateMany: aDocument 
				with: newDocument 
				collection: aMongoCollection 
				upsert: upsertBoolean ]
		ifFalse: [
			self 
				updateOne: aDocument
				with: newDocument 
				collection: aMongoCollection 
				upsert: upsertBoolean ]
]

{ #category : 'operations' }
MongoDriverC >> updateMany: aDocument with: newDocument collection: aMongoCollection upsert: upsertBoolean [
	| filter update result reply error replyJson opts matchedCount modifiedCount |

	filter := self jsonToBson: aDocument.
	update := self jsonToBson: { '$set' -> newDocument } asDictionary.
	reply := BsonT new.
	error :=  BsonErrorT new.
	opts := BsonT null.
	result := 0.
	
	upsertBoolean ifTrue: [
		opts := self jsonToBson: { #upsert -> true } asDictionary ].
	
	[ 
		result := mongoc 
			collection_update_manyCollection: (self collectionFor: aMongoCollection)
			selector: filter getHandle
			update: update getHandle
			opts: opts getHandle 
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.

		result = 1
			ifTrue: [
				replyJson := self bsonToJson: reply.
				matchedCount := replyJson at: 'matchedCount'.
				modifiedCount := replyJson at: 'modifiedCount' ]
			ifFalse: [ 
				MongoCCommandError signalFor: error ] ] 
	ensure: [
 		bson destroy: filter.
 		bson destroy: update.
 		opts isNullOrNil 
 			ifFalse: [ bson destroy: opts ].
 		((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 
 	^ { matchedCount. modifiedCount }
]

{ #category : 'operations' }
MongoDriverC >> updateOne: aDocument with: newDocument collection: aMongoCollection upsert: upsertBoolean [
	| filter update result reply error replyJson opts matchedCount modifiedCount |

	filter := self jsonToBson: aDocument.
	update := self jsonToBson: { '$set' -> newDocument } asDictionary.
	reply := BsonT new.
	error :=  BsonErrorT new.
	opts := BsonT null.
	result := 0.
	
	upsertBoolean ifTrue: [
		opts := self jsonToBson: { #upsert -> true } asDictionary ].
	
	[ 
		result := mongoc 
			collection_update_oneCollection: (self collectionFor: aMongoCollection)
			selector: filter getHandle
			update: update getHandle
			opts: opts getHandle 
			reply: reply referenceTo getHandle
			error: error referenceTo getHandle.

		result = 1
			ifTrue: [
				replyJson := self bsonToJson: reply.
				matchedCount := replyJson at: 'matchedCount'.
				modifiedCount := replyJson at: 'modifiedCount' ]
			ifFalse: [ 
				MongoCCommandError signalFor: error ] ] 
	ensure: [
 		bson destroy: filter.
 		bson destroy: update.
 		opts isNullOrNil 
 			ifFalse: [ bson destroy: opts ].
 		((result = 1) and: [ reply isNullOrNil not ]) 
 			ifTrue: [ bson destroy: reply ] ].
 
 	^ { matchedCount. modifiedCount }
]

{ #category : 'private' }
MongoDriverC >> writeConcernToMongo: aWriteConcern [
	"takes a MongoWriteConcern and converts it to a McWriteConcernT object"
	| writeConcern |
	
	writeConcern := mongoc write_concern_new.
	"not very clear what w is... something to write :P. 
	 https://mongoc.org/libmongoc/current/mongoc_write_concern_set_w.html"
	aWriteConcern w ifNotNil: [ 
		mongoc 
			write_concern_set_wWrite_concern: writeConcern 
			w: aWriteConcern w ].
	"j = journal"
	aWriteConcern j ifTrue: [ 
		mongoc 
			write_concern_set_journalWrite_concern: writeConcern 
			journal: true ].
	"wtimetout = write timeout"
	aWriteConcern wtimeout ifNotNil: [ 
		mongoc 
			write_concern_set_wtimeoutWrite_concern: writeConcern 
			wtimeout_msec: aWriteConcern wtimeout ].
		
	^ writeConcern
]
