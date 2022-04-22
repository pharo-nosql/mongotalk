"
Operation to update a collection
"
Class {
	#name : #UpdateOperation,
	#superclass : #MongoOperation,
	#instVars : [
		'originalObject',
		'newObject',
		'dataBytes',
		'flags'
	],
	#category : 'Mongo-Core-Operations'
}

{ #category : #'instance creation' }
UpdateOperation class >> collection: aString id: idInteger stream: aStream originalObject: origDictionary newObject: newDictionary [
	^(self collection: aString
		id: idInteger
		stream: aStream)
			originalObject: origDictionary;
			newObject: newDictionary
]

{ #category : #flags }
UpdateOperation class >> flagMultiUpdate [
	"1 corresponds to MultiUpdate.If set, the database will update all matching objects in the collection. Otherwise only updates first matching document."
	^2
]

{ #category : #flags }
UpdateOperation class >> flagUpsert [
"0 corresponds to Upsert. If set, the database will insert the supplied object into the collection if no matching document is found."
	^1
]

{ #category : #writing }
UpdateOperation >> computeDataBytes [
	^ BSON writeAll: (Array 
		with: originalObject
		with: newObject)
]

{ #category : #writing }
UpdateOperation >> dataBytes [
	^dataBytes ifNil: [dataBytes := self computeDataBytes]
]

{ #category : #writing }
UpdateOperation >> fixedHeaderSize [
	^ 24
]

{ #category : #'as yet unclassified' }
UpdateOperation >> flags [
	^ flags ifNil: [ 0 ]
]

{ #category : #'as yet unclassified' }
UpdateOperation >> flags: aFlags [
	flags := aFlags
]

{ #category : #writing }
UpdateOperation >> messageSize [
	^ self dataBytes size + collectionBytes size + 1 + self fixedHeaderSize
]

{ #category : #accessing }
UpdateOperation >> newObject: anObject [ 
	newObject := anObject
]

{ #category : #private }
UpdateOperation >> opCode [
	^2001
]

{ #category : #accessing }
UpdateOperation >> originalObject: anObject [ 
	originalObject := anObject
]

{ #category : #writing }
UpdateOperation >> writeBody [
	writer
		nextInt32Put: 0;
		nextEncodedStringPut: collectionBytes;
		nextInt32Put: self flags;
		nextBytesPut: self dataBytes
]
