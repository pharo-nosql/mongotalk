"
I implement the SCRAM-SHA1 authentication mechanism.

See: https://docs.mongodb.com/v4.0/core/security-scram/

"
Class {
	#name : #SCRAMSHA1AuthMechanism,
	#superclass : #SCRAMAuthMechanism,
	#category : 'Mongo-Core-Auth'
}

{ #category : #accessing }
SCRAMSHA1AuthMechanism class >> description [
	^ 'SCRAM-SHA-1'
]

{ #category : #accessing }
SCRAMSHA1AuthMechanism class >> isAbstract [
	^ false
]

{ #category : #operations }
SCRAMSHA1AuthMechanism >> hashFunction [
	^ SHA1
]

{ #category : #operations }
SCRAMSHA1AuthMechanism >> mechanismName [
	^ 'SCRAM-SHA-1'
]
