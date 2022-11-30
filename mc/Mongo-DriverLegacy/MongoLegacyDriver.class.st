"
A legacy driver for mongo wire protocol (previous to v5.0) 
"
Class {
	#name : #MongoLegacyDriver,
	#superclass : #MongoDriver,
	#category : #'Mongo-DriverLegacy-Base'
}

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
