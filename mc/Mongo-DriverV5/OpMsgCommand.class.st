"
Implementation of OP_MSG for commands.

"
Class {
	#name : #OpMsgCommand,
	#superclass : #OpMSG,
	#instVars : [
		'mongoQuery',
		'flags',
		'sections'
	],
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #private }
OpMsgCommand >> bodySize [

	^ self sectionsSize + FLAGS_SIZE
]

{ #category : #accessing }
OpMsgCommand >> flags [

	^ flags ifNil: [ 0 ]
]

{ #category : #accessing }
OpMsgCommand >> flags: aFlags [

	flags := aFlags
]

{ #category : #private }
OpMsgCommand >> messageSize [

	^ self fixedHeaderSize + self bodySize
]

{ #category : #accessing }
OpMsgCommand >> mongoQuery [

	^ mongoQuery
]

{ #category : #accessing }
OpMsgCommand >> mongoQuery: aMongoQuery [

	mongoQuery := aMongoQuery
]

{ #category : #private }
OpMsgCommand >> sections [

	^ sections ifNil: [ 
		sections := { OpMsgSectionForCommand fromQuery: self mongoQuery } ]
]

{ #category : #private }
OpMsgCommand >> sectionsSize [

	^ self sections sum: [ :each | each size ]
]

{ #category : #initialization }
OpMsgCommand >> setCollection: aString id: idInteger stream: aStream [

	id := idInteger.
	writer := LittleEndianStream on: aStream
]

{ #category : #writing }
OpMsgCommand >> writeBody [

	writer nextInt32Put: self flags.
	self sections do: [ :each | 
		each writeOn: writer ].
]
