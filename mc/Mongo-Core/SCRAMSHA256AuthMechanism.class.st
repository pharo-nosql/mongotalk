Class {
	#name : #SCRAMSHA256AuthMechanism,
	#superclass : #SCRAMAuthMechanism,
	#category : 'Mongo-Core-Auth'
}

{ #category : #accessing }
SCRAMSHA256AuthMechanism class >> description [
	^ 'SCRAM-SHA-256'
]

{ #category : #accessing }
SCRAMSHA256AuthMechanism class >> isAbstract [
	^ false
]

{ #category : #operations }
SCRAMSHA256AuthMechanism >> hashFunction [
	^ SHA256
]

{ #category : #operations }
SCRAMSHA256AuthMechanism >> mechanismName [
	^ 'SCRAM-SHA-256'
]
