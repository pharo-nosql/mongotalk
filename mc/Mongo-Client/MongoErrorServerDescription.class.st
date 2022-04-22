"
I represent the description of a server that had a network error.

Spec: 'If the client experiences any error when checking a server, it stores error information in the ServerDescription's error field.'

"
Class {
	#name : #MongoErrorServerDescription,
	#superclass : #MongoAbstractServerDescription,
	#instVars : [
		'errorDescription'
	],
	#category : 'Mongo-Client-Topology'
}

{ #category : #'instance creation' }
MongoErrorServerDescription class >> urlString: urlString errorDescription: anErrorDescription [
	^ self basicNew
		initializeUrlString: urlString errorDescription: anErrorDescription;
		yourself
]

{ #category : #initialization }
MongoErrorServerDescription >> initializeUrlString: aUrlString errorDescription: anErrorDescription [
	self initializeUrlString: aUrlString.
	errorDescription := anErrorDescription.

]

{ #category : #testing }
MongoErrorServerDescription >> isError [
	^ true
]
