Class {
	#name : #OpMsgSectionType1,
	#superclass : #OpMsgSection,
	#instVars : [
		'id'
	],
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #private }
OpMsgSectionType1 >> computeSize [

	^ self bytes size + TYPE_SIZE + self id size + NULL_SIZE
]

{ #category : #initialization }
OpMsgSectionType1 >> fromStream: stream size: streamSize [

	self shouldBeImplemented
]

{ #category : #accessing }
OpMsgSectionType1 >> id [

	^ id
]

{ #category : #accessing }
OpMsgSectionType1 >> type [

	^ 1
]

{ #category : #writing }
OpMsgSectionType1 >> writeOn: writer [

	super writeOn: writer.	
	writer
		nextInt32Put: self size;
		nextStringPut: self id;
		nextBytesPut: self bytes
]
