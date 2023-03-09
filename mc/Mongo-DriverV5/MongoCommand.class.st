Class {
	#name : #MongoCommand,
	#superclass : #Object,
	#instVars : [
		'root',
		'query'
	],
	#category : #'Mongo-DriverV5-Base'
}

{ #category : #'instance creation' }
MongoCommand class >> root: aMongo query: aMongoQuery [
	^self new
		root: aMongo;
		query: aMongoQuery
]

{ #category : #executing }
MongoCommand >> execute [
	| reply requestId |

	requestId := root cursorQuery: query.
	reply := OpMsgReply fromStream: root stream.
	reply responseTo = requestId
		ifFalse: [ ^ MongoWireProtocolError signal: 'Unexpected responseTo in response' ].
	reply isOk
		ifFalse: [ ^ MongoCommandError signalFor: reply documents first ].

	reply do: [:each |
		query doBlock value: each ]
]

{ #category : #accessing }
MongoCommand >> query [
	^ query
]

{ #category : #accessing }
MongoCommand >> query: anObject [

	query := anObject
]

{ #category : #accessing }
MongoCommand >> root [
	^ root
]

{ #category : #accessing }
MongoCommand >> root: anObject [
	root := anObject
]
