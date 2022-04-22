"
My subclasses are Mongo errors, which are originally represented with Dictionary.
"
Class {
	#name : #MongoNativeError,
	#superclass : #Error,
	#instVars : [
		'reply'
	],
	#category : 'Mongo-Core-Errors'
}

{ #category : #'instance creation' }
MongoNativeError class >> newFor: aReply [
	^self basicNew
		initialize: aReply;
		yourself
]

{ #category : #signalling }
MongoNativeError class >> signalFor: aReply [
	^ (self newFor: aReply) signal
]

{ #category : #accessing }
MongoNativeError >> code [
	^ reply at: 'code'
]

{ #category : #accessing }
MongoNativeError >> codeIfPresent: presentBlock ifAbsent: absentBlock [
	^ reply 
		at: 'code' 
		ifPresent: [ :code | presentBlock cull: code ]
		ifAbsent: absentBlock
]

{ #category : #accessing }
MongoNativeError >> errorMessage [
	"Answer a String description of the Mongo native error"
	
	^ self subclassResponsibility
]

{ #category : #initialization }
MongoNativeError >> initialize: aReply [
	self initialize.
	reply := aReply.
]

{ #category : #accessing }
MongoNativeError >> messageText [
	^ self errorMessage
]

{ #category : #accessing }
MongoNativeError >> reply [
	^reply
]
