"
Base section for payload type 0
"
Class {
	#name : #OpMsgSectionType0,
	#superclass : #OpMsgSection,
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #private }
OpMsgSectionType0 >> computeSize [
	
	^ self bytes size + 1 "type"
]

{ #category : #initialization }
OpMsgSectionType0 >> fromStream: stream size: aNumber [
	
	bytes := stream nextBytes: aNumber.
	document := BSON read: bytes readStream
]

{ #category : #accessing }
OpMsgSectionType0 >> type [

	^ 0
]

{ #category : #writing }
OpMsgSectionType0 >> writeOn: writer [

	super writeOn: writer.
	writer nextBytesPut: self bytes
]
