"
Section for queries. 
Used in `OpMsgQuery`
"
Class {
	#name : #OpMsgSectionForQuery,
	#superclass : #OpMsgSectionType0,
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #'instance creation' }
OpMsgSectionForQuery class >> fromQuery: aMongoQuery [

	^ self new fromQuery: aMongoQuery
]

{ #category : #private }
OpMsgSectionForQuery >> fromQuery: aQuery [

	document := OrderedDictionary new
		at: 'find' put: aQuery collection name;
		at: '$db' put: aQuery database name;
		at: 'filter' put: aQuery where;
		yourself.

	aQuery offset > 0 ifTrue: [ document at: 'skip' put: aQuery offset ].
	aQuery limit > 0 ifTrue: [  document at: 'limit' put: aQuery limit ].
	aQuery chunkSize > 0 ifTrue: [ document at: 'batchSize' put: aQuery chunkSize ].
	aQuery order ifNotNil: [ document at: 'sort' put: aQuery order ].
	aQuery fields ifNotNil: [ :fields |
		document
			at: 'projection'
			put: (fields keys collect: [ :each | each -> 1 ]) asOrderedDictionary ].

	bytes := BSON writer
		nextOrderedDictionaryPut: document;
		contents
]
