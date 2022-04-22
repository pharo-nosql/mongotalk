"
Common superclass for Mongo authentication mechanisms.
"
Class {
	#name : #MongoAuthMechanism,
	#superclass : #Object,
	#instVars : [
		'root',
		'forceDatabase'
	],
	#classInstVars : [
		'authAgainstAdmin'
	],
	#category : 'Mongo-Core-Auth'
}

{ #category : #accessing }
MongoAuthMechanism class >> authAgainstAdmin [
	^ authAgainstAdmin ifNil: [ false ]
]

{ #category : #accessing }
MongoAuthMechanism class >> authAgainstAdmin: boolean [
	authAgainstAdmin := boolean
]

{ #category : #accessing }
MongoAuthMechanism class >> beDefault [
	Mongo defaultAuthMechanismClass: self
]

{ #category : #accessing }
MongoAuthMechanism class >> description [
	^ self subclassResponsibility 
]

{ #category : #accessing }
MongoAuthMechanism class >> isAbstract [
	^ true
]

{ #category : #accessing }
MongoAuthMechanism class >> root: root [
	|mech|
	mech := self new root: root.
	self authAgainstAdmin ifTrue: [ mech  forceDatabase: root admin].
	^ mech
		
]

{ #category : #operations }
MongoAuthMechanism >> authenticateUsername: user password: pass database: aDatabase [
	^self authenticateUsername: user password: pass forcedDatabase: (self forceDatabase ifNil: [ aDatabase ])
]

{ #category : #operations }
MongoAuthMechanism >> authenticateUsername: user password: pass forcedDatabase: aDatabase [
	^ self subclassResponsibility
]

{ #category : #accessing }
MongoAuthMechanism >> forceDatabase [
	^ forceDatabase
]

{ #category : #accessing }
MongoAuthMechanism >> forceDatabase: anObject [
	forceDatabase := anObject
]

{ #category : #accessing }
MongoAuthMechanism >> root [
	^ root
]

{ #category : #accessing }
MongoAuthMechanism >> root: anObject [
	root := anObject
]
