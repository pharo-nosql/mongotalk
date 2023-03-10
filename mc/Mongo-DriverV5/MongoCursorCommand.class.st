"
A command to execute commands in mongo (this would be the equivallent of `runCommand` in the mongo cli)
"
Class {
	#name : #MongoCursorCommand,
	#superclass : #MongoCursor,
	#category : #'Mongo-DriverV5-Base'
}

{ #category : #private }
MongoCursorCommand >> driver [

	^ root driver
]

{ #category : #executing }
MongoCursorCommand >> execute [
	| reply requestId |

	requestId := self cursorQuery: query.
	reply := OpMsgReply fromStream: root stream.
	reply responseTo = requestId
		ifFalse: [ ^ MongoWireProtocolError signal: 'Unexpected responseTo in response' ].
	reply isOk
		ifFalse: [ ^ MongoCommandError signalFor: reply firstDocument ].

	query doBlock value: reply firstDocument
]
