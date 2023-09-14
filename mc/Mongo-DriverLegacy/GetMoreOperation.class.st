"
Retrieve more objects
"
Class {
	#name : #GetMoreOperation,
	#superclass : #MongoOperation,
	#instVars : [
		'cursorId',
		'returnCount'
	],
	#category : #'Mongo-DriverLegacy-Operations'
}

{ #category : #'instance creation' }
GetMoreOperation class >> collection: aString id: idInteger stream: aStream cursorId: cursorInteger returnCount: countInteger [
	^(self collection: aString
		id: idInteger
		stream: aStream)
			setCursorId: cursorInteger
			returnCount: countInteger 
]

{ #category : #writing }
GetMoreOperation >> fixedHeaderSize [
	^ 32
]

{ #category : #writing }
GetMoreOperation >> messageSize [
	^ collectionBytes size + 1 + self fixedHeaderSize
]

{ #category : #private }
GetMoreOperation >> opCode [
	^2005
]

{ #category : #private }
GetMoreOperation >> setCursorId: cursorInteger returnCount: countInteger [
	cursorId := cursorInteger.
	returnCount := countInteger 
]

{ #category : #writing }
GetMoreOperation >> writeBody [
	writer
		nextInt32Put: 0;
		nextEncodedStringPut: collectionBytes;
		nextInt32Put: returnCount;
		nextInt64Put: cursorId
]
