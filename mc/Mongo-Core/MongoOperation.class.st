"
Common superclass for Mongo database operations on the Wire Protocol.

See: https://docs.mongodb.com/v4.0/reference/mongodb-wire-protocol/
"
Class {
	#name : #MongoOperation,
	#superclass : #Object,
	#instVars : [
		'id',
		'writer',
		'collectionBytes'
	],
	#category : #'Mongo-Core-Operations'
}

{ #category : #'private-instance creation' }
MongoOperation class >> collection: aString id: idInteger stream: aStream [
	^ self new
		setCollection: aString
		id: idInteger
		stream: aStream
]

{ #category : #writing }
MongoOperation >> flush [

	writer flush
]

{ #category : #private }
MongoOperation >> messageSize [

	^ self subclassResponsibility
]

{ #category : #private }
MongoOperation >> opCode [

	^ self subclassResponsibility
]

{ #category : #private }
MongoOperation >> setCollection: aString id: idInteger stream: aStream [

	id := idInteger.
	writer := LittleEndianStream on: aStream.
	collectionBytes := writer encode: aString
	
]

{ #category : #writing }
MongoOperation >> write [

	self writeHeader.
	self writeBody.
	self flush
]

{ #category : #writing }
MongoOperation >> writeBody [
	
]

{ #category : #writing }
MongoOperation >> writeHeader [

	writer
		nextInt32Put: self messageSize;
		nextInt32Put: id;
		nextInt32Put: 0;
		nextInt32Put: self opCode
]
