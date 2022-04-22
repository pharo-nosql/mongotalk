"
A mock for mongo to be used in the tests

Instance Variables
	authCalls:		<Object>
	succeedAuth:		<Object>

authCalls
	- xxxxx

succeedAuth
	- xxxxx

"
Class {
	#name : #MongoMock,
	#superclass : #Mongo,
	#instVars : [
		'succeedAuth',
		'authCalls'
	],
	#category : 'Mongo-Tests-Core-Mocks'
}

{ #category : #accessing }
MongoMock >> authCalls [
	^ authCalls
]

{ #category : #accessing }
MongoMock >> authShouldFail [
	succeedAuth := false
]

{ #category : #operations }
MongoMock >> authenticateUsername: user password: pass database: aDatabase [
	authCalls := authCalls + 1.
	^ succeedAuth 
]

{ #category : #'initialize-release' }
MongoMock >> initialize [ 
	super initialize.
	succeedAuth := true.
	authCalls := 0
]

{ #category : #accessing }
MongoMock >> reset [
	authCalls := 0.
	authCache := Dictionary new
	
]
