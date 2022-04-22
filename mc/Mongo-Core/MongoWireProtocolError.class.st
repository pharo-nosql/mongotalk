"
Error signalled for failures related to the wire protocol.
"
Class {
	#name : #MongoWireProtocolError,
	#superclass : #MongoNativeError,
	#category : 'Mongo-Core-Errors'
}

{ #category : #accessing }
MongoWireProtocolError >> errorMessage [
	^ self messageText
]
