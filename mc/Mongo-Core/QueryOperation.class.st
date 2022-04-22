"
A query in the Wire Protocol.

See: https://docs.mongodb.com/v4.0/reference/mongodb-wire-protocol/#wire-op-query
"
Class {
	#name : #QueryOperation,
	#superclass : #MongoOperation,
	#instVars : [
		'mongoQuery',
		'dataBytes',
		'flags'
	],
	#category : 'Mongo-Core-Operations'
}

{ #category : #'instance creation' }
QueryOperation class >> collection: aString id: idInteger stream: aStream query: queryDictionary fields: fieldsDictionary returnCount: countInteger numberToSkip: skipInteger [
	self deprecated: 'Should be replaced by id:stream:query:'.
	^(self
		collection: aString 
		id: idInteger 
		stream: aStream)
			setQuery: queryDictionary 
			fields: fieldsDictionary 
			returnCount: countInteger
			numberToSkip: skipInteger
]

{ #category : #flags }
QueryOperation class >> flagAwaitData [
	"5 corresponds to AwaitData. Use with TailableCursor. If we are at the end of the data, block for a while rather than returning no data. After a timeout period, we do return as normal."
	^32
]

{ #category : #flags }
QueryOperation class >> flagExhaust [
	"6 corresponds to Exhaust. Stream the data down full blast in multiple “more” packages, on the assumption that the client will fully read all data queried. Faster when you are pulling a lot of data and know you want to pull it all down. Note: the client is not allowed to not read all the data unless it closes the connection"
	^64
]

{ #category : #flags }
QueryOperation class >> flagNoCursorTimeout [
	"4 corresponds to NoCursorTimeout. The server normally times out idle cursors after an inactivity period (10 minutes) to prevent excess memory use. Set this option to prevent that."
	^16
]

{ #category : #flags }
QueryOperation class >> flagPartial [
	"7 corresponds to Partial. Get partial results from a mongos if some shards are down (instead of throwing an error)"
	^128
]

{ #category : #flags }
QueryOperation class >> flagReserved [
	"0 is reserved. Must be set to 0."
	^0
]

{ #category : #flags }
QueryOperation class >> flagSlaveOk [
	"2 corresponds to SlaveOk.Allow query of replica slave. Normally these return an error except for namespace 'local'."
	^4
]

{ #category : #flags }
QueryOperation class >> flagTailableCursor [
"1 corresponds to TailableCursor. Tailable means cursor is not closed when the last data is retrieved. Rather, the cursor marks the final object’s position. You can resume using the cursor later, from where it was located, if more data were received. Like any “latent cursor”, the cursor may become invalid at some point (CursorNotFound) – for example if the final object it references were deleted."
	^2
]

{ #category : #'instance creation' }
QueryOperation class >> id: idInteger stream: aStream query: aMongoQuery [
	^(self
		collection: aMongoQuery qualifiedName 
		id: idInteger 
		stream: aStream)
			mongoQuery: aMongoQuery
]

{ #category : #writing }
QueryOperation >> computeDataBytes [
	| queryDictionary |
	queryDictionary := Dictionary new
		at: '$query' put: mongoQuery where;
		yourself.
	mongoQuery order ifNotNil: [
		queryDictionary at: '$orderby' put: mongoQuery order].
	
	^mongoQuery fields 
		ifNotNil: [BSON writeAll: { queryDictionary . mongoQuery fields}]
		ifNil: [BSON write: queryDictionary]
]

{ #category : #writing }
QueryOperation >> dataBytes [ 
	^dataBytes ifNil: [dataBytes := self computeDataBytes]
]

{ #category : #writing }
QueryOperation >> fixedHeaderSize [
	^ 28
]

{ #category : #accessing }
QueryOperation >> flags [
	^ flags ifNil: [ 0 ]
]

{ #category : #accessing }
QueryOperation >> flags: aFlags [
	flags := aFlags
]

{ #category : #writing }
QueryOperation >> messageSize [
	^ self dataBytes size + collectionBytes size + 1 + self fixedHeaderSize
]

{ #category : #accessing }
QueryOperation >> mongoQuery [
	^ mongoQuery
]

{ #category : #accessing }
QueryOperation >> mongoQuery: aMongoQuery [
	mongoQuery := aMongoQuery
]

{ #category : #private }
QueryOperation >> opCode [
	^2004
]

{ #category : #writing }
QueryOperation >> writeBody [
	writer
		nextInt32Put: self flags;
		nextEncodedStringPut: collectionBytes;
		nextInt32Put: mongoQuery offset; "number of elements to skip"
		nextInt32Put: mongoQuery chunkSize;
		nextBytesPut: self dataBytes.
		
		"order is to be integrated in the dataBytes"
]
