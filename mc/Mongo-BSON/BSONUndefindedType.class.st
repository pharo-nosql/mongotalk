"
Error thrown when the type is undefined 

Instance Variables
	code:		<Object>

code
	- xxxxx

"
Class {
	#name : #BSONUndefindedType,
	#superclass : #BSONError,
	#instVars : [
		'code'
	],
	#category : 'Mongo-BSON-Exceptions'
}

{ #category : #'as yet unclassified' }
BSONUndefindedType class >> signalCode: aNumber [
	^self new 
		code: aNumber;
		signal
]

{ #category : #accessing }
BSONUndefindedType >> code [
	^code
]

{ #category : #accessing }
BSONUndefindedType >> code: aNumber [
	code := aNumber
]

{ #category : #accessing }
BSONUndefindedType >> messageText [ 
	^'Undefined type ', self code asString
]
