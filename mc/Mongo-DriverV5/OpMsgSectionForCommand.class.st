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

	"commands are tobe sent 'as is'.
	 but there need to be in order (and $db can't be the first).
	So we send it as an OrderedDictionary"
	document := aQuery where asOrderedDictionary
		at: '$db' put: aQuery database name;
		yourself.

	bytes := BSON writer
		nextOrderedDictionaryPut: document;
		contents
]
