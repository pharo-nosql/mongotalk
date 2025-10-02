"
Section for queries. 
Used in `OpMsgQuery`
"
Class {
	#name : 'OpMsgSectionForQuery',
	#superclass : 'OpMsgSectionType0',
	#category : 'Mongo-DriverV5-Operations',
	#package : 'Mongo-DriverV5',
	#tag : 'Operations'
}

{ #category : 'instance creation' }
OpMsgSectionForQuery class >> fromQuery: aMongoQuery [

	^ self new fromQuery: aMongoQuery
]

{ #category : 'private' }
OpMsgSectionForQuery >> fromQuery: aQuery [

	document := OrderedDictionary new
		at: 'find' put: aQuery collection name;
		at: '$db' put: aQuery database name;
		at: 'filter' put: aQuery where;
		yourself.
	aQuery fillOptionsTo: document.

	bytes := BSON writer
		nextOrderedDictionaryPut: document;
		contents
]
