Class {
	#name : #OpMsgSectionForCommand,
	#superclass : #OpMsgSectionType0,
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #'instance creation' }
OpMsgSectionForCommand class >> fromQuery: aMongoQuery [

	^ self new fromQuery: aMongoQuery
]

{ #category : #private }
OpMsgSectionForCommand >> fromQuery: aQuery [

	"commands are tobe sent 'as is'"
	document := aQuery where copy
		at: '$db' put: aQuery database name;
		yourself.

	bytes := BSON writer
		nextOrderedDictionaryPut: document;
		contents
]
