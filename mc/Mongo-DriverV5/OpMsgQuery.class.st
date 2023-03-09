"
Implementation of OP_MSG for queries.

It will be used on `MongoCollection>>#query:` and `MongoCollection>>#queryOne:`.

maybe others?
"
Class {
	#name : #OpMsgQuery,
	#superclass : #OpMSG,
	#instVars : [
		'mongoQuery',
		'flags',
		'section',
		'sections'
	],
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #private }
OpMsgQuery >> bodySize [

	^ self sectionsSize + FLAGS_SIZE
]

{ #category : #accessing }
OpMsgQuery >> flags [

	^ flags ifNil: [ 0 ]
]

{ #category : #accessing }
OpMsgQuery >> flags: aFlags [

	flags := aFlags
]

{ #category : #private }
OpMsgQuery >> messageSize [

	^ self fixedHeaderSize + self bodySize
]

{ #category : #accessing }
OpMsgQuery >> mongoQuery [

	^ mongoQuery
]

{ #category : #accessing }
OpMsgQuery >> mongoQuery: aMongoQuery [

	mongoQuery := aMongoQuery
]

{ #category : #private }
OpMsgQuery >> sections [

	^ sections ifNil: [ 
		sections := { OpMsgSectionForQuery fromQuery: self mongoQuery } ]
]

{ #category : #private }
OpMsgQuery >> sectionsSize [

	^ self sections sum: [ :each | each size ]
]

{ #category : #writing }
OpMsgQuery >> writeBody [

	writer nextInt32Put: self flags.
	self sections do: [ :each | 
		each writeOn: writer ].
]
