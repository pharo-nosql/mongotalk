"
Delete operation
"
Class {
	#name : #DeleteOperation,
	#superclass : #MongoOperation,
	#instVars : [
		'query',
		'dataBytes'
	],
	#category : #'Mongo-DriverLegacy-Operations'
}

{ #category : #'instance creation' }
DeleteOperation class >> collection: aString id: idInteger stream: aStream query: aDictionary [
	^(self
		collection: aString 
		id: idInteger 
		stream: aStream)
			setQuery: aDictionary
]

{ #category : #writing }
DeleteOperation >> computeDataBytes [
	^ BSON write: query
]

{ #category : #writing }
DeleteOperation >> dataBytes [
	^dataBytes ifNil: [dataBytes := self computeDataBytes]
]

{ #category : #writing }
DeleteOperation >> fixedHeaderSize [
	^ 24
]

{ #category : #writing }
DeleteOperation >> messageSize [
	^ self dataBytes size + collectionBytes size + 1 + self fixedHeaderSize
]

{ #category : #private }
DeleteOperation >> opCode [
	^2006
]

{ #category : #private }
DeleteOperation >> setQuery: aDictionary [
	query := aDictionary 
]

{ #category : #writing }
DeleteOperation >> writeBody [
	writer
		nextInt32Put: 0;
		nextEncodedStringPut: collectionBytes;
		nextInt32Put: 0;
		nextBytesPut: self dataBytes
]
