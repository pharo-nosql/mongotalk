"
A driver from mongo wire protocol from v5.0 and later
"
Class {
	#name : #MongoDriverV5,
	#superclass : #MongoDriver,
	#category : #'Mongo-DriverV5-Base'
}

{ #category : #testing }
MongoDriverV5 class >> isDefault [

	^ true
]

{ #category : #factory }
MongoDriverV5 >> newCommand: anOrderedDictionary database: aDatabase flags: flags [

	^ self newQuery
		database: aDatabase;
		collection: MongoCollection cmdVirtualCollection;
		where: anOrderedDictionary;
		flags: flags;
		yourself
]

{ #category : #factory }
MongoDriverV5 >> newQuery [

	^ super newQuery 
		operation: OpMsgQuery;
		yourself
]
