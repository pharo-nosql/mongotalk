"
Insert operation
"
Class {
	#name : #InsertOperation,
	#superclass : #MongoOperation,
	#instVars : [
		'objects',
		'dataBytes'
	],
	#category : 'Mongo-Core-Operations'
}

{ #category : #'instance creation' }
InsertOperation class >> collection: aString id: idInteger stream: aStream objects: aCollection [
	^(self collection: aString
		id: idInteger
		stream: aStream)
			setObjects: aCollection 
]

{ #category : #writing }
InsertOperation >> computeDataBytes [
	^ BSON writeAll: objects
]

{ #category : #writing }
InsertOperation >> dataBytes [
	^dataBytes ifNil: [dataBytes := self computeDataBytes]
]

{ #category : #writing }
InsertOperation >> fixedHeaderSize [
	^ 20
]

{ #category : #writing }
InsertOperation >> messageSize [
	^ self dataBytes size + collectionBytes size + 1 + self fixedHeaderSize
]

{ #category : #private }
InsertOperation >> opCode [
	^2002
]

{ #category : #private }
InsertOperation >> setObjects: aCollection [
	objects := aCollection
]

{ #category : #writing }
InsertOperation >> writeBody [
	writer
		nextInt32Put: 0;
		nextEncodedStringPut: collectionBytes;
		nextBytesPut: self dataBytes
]
