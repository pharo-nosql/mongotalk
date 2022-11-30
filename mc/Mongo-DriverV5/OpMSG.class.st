"
A base for OP_MSG opcode. 
Most of the operations we want to do execute with the driver V5 will use this op code.

See:

- https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol
- https://github.com/mongodb/specifications/blob/master/source/message/OP_MSG.rst


"
Class {
	#name : #OpMSG,
	#superclass : #MongoOperation,
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #'instance creation' }
OpMSG class >> collection: aString id: idInteger stream: aStream query: queryDictionary fields: fieldsDictionary returnCount: countInteger numberToSkip: skipInteger [
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
OpMSG class >> flagAwaitData [
	"5 corresponds to AwaitData. Use with TailableCursor. If we are at the end of the data, block for a while rather than returning no data. After a timeout period, we do return as normal."
	^32
]

{ #category : #flags }
OpMSG class >> flagExhaust [
	"6 corresponds to Exhaust. Stream the data down full blast in multiple “more” packages, on the assumption that the client will fully read all data queried. Faster when you are pulling a lot of data and know you want to pull it all down. Note: the client is not allowed to not read all the data unless it closes the connection"
	^64
]

{ #category : #flags }
OpMSG class >> flagNoCursorTimeout [
	"4 corresponds to NoCursorTimeout. The server normally times out idle cursors after an inactivity period (10 minutes) to prevent excess memory use. Set this option to prevent that."
	^16
]

{ #category : #flags }
OpMSG class >> flagPartial [
	"7 corresponds to Partial. Get partial results from a mongos if some shards are down (instead of throwing an error)"
	^128
]

{ #category : #flags }
OpMSG class >> flagReserved [
	"0 is reserved. Must be set to 0."
	^0
]

{ #category : #flags }
OpMSG class >> flagSlaveOk [
	"2 corresponds to SlaveOk.Allow query of replica slave. Normally these return an error except for namespace 'local'."
	^4
]

{ #category : #flags }
OpMSG class >> flagTailableCursor [
"1 corresponds to TailableCursor. Tailable means cursor is not closed when the last data is retrieved. Rather, the cursor marks the final object’s position. You can resume using the cursor later, from where it was located, if more data were received. Like any “latent cursor”, the cursor may become invalid at some point (CursorNotFound) – for example if the final object it references were deleted."
	^2
]

{ #category : #'instance creation' }
OpMSG class >> id: idInteger stream: aStream query: aMongoQuery [
	^(self
		collection: aMongoQuery qualifiedName 
		id: idInteger 
		stream: aStream)
			mongoQuery: aMongoQuery
]

{ #category : #private }
OpMSG >> fixedHeaderSize [

	^ "28"16
]

{ #category : #private }
OpMSG >> opCode [

	^ 2013
]
