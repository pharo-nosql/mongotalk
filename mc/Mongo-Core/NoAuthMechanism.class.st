Class {
	#name : #NoAuthMechanism,
	#superclass : #MongoAuthMechanism,
	#category : 'Mongo-Core-Auth'
}

{ #category : #accessing }
NoAuthMechanism class >> description [
	^ 'No authentication'
]

{ #category : #accessing }
NoAuthMechanism class >> isAbstract [
	^ false
]

{ #category : #operations }
NoAuthMechanism >> authenticateUsername: user password: pass forcedDatabase: aDatabase [
]
