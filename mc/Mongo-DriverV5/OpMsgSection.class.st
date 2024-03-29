"
base for OP_MSG section.

See:

- https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol
- https://github.com/mongodb/specifications/blob/master/source/message/OP_MSG.rst
"
Class {
	#name : #OpMsgSection,
	#superclass : #Object,
	#instVars : [
		'bytes',
		'size',
		'document'
	],
	#classVars : [
		'NULL_SIZE',
		'TYPE_SIZE'
	],
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #'instance creation' }
OpMsgSection class >> fromStream: stream size: size [
	
	^ (self sectionClass: stream nextByte) new
		fromStream: stream size: size - 1;
		yourself
]

{ #category : #'class initialization' }
OpMsgSection class >> initialize [

	TYPE_SIZE := 1.
	NULL_SIZE := 1
]

{ #category : #private }
OpMsgSection class >> sectionClass: type [

	type = 0 ifTrue: [ ^ OpMsgSectionType0 ].
	type = 1 ifTrue: [ ^ OpMsgSectionType1 ].
	
	self error: 'Should not arrive here'
]

{ #category : #accessing }
OpMsgSection >> batchDocuments [
	"used to traverse batched answers"

	^ self document
		at: #cursor
		ifPresent: [ :cursor | cursor at: #firstBatch ifAbsent: [ cursor at: #nextBatch ] ]
		ifAbsent: [ { self document } ]
]

{ #category : #accessing }
OpMsgSection >> bytes [

	^ bytes
]

{ #category : #private }
OpMsgSection >> computeSize [

	self subclassResponsibility
]

{ #category : #accessing }
OpMsgSection >> document [

	^ document
]

{ #category : #initialization }
OpMsgSection >> fromStream: stream size: streamSize [

	self subclassResponsibility
]

{ #category : #accessing }
OpMsgSection >> size [

	^ size ifNil: [ size := self computeSize ]
]

{ #category : #accessing }
OpMsgSection >> type [

	^ self subclassResponsibility
]

{ #category : #writing }
OpMsgSection >> writeOn: writer [

	writer nextBytePut: self type
]
