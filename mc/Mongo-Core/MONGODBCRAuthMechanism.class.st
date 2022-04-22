"
I implement the MONGODB-CR authentication mechanism.

Note this mechanism was deprecated in mongodb 3.6 and removed in 4.0.

See: 
- https://docs.mongodb.com/v3.6/core/security-mongodb-cr/
- https://docs.mongodb.com/v4.0/release-notes/3.0-scram/

"
Class {
	#name : #MONGODBCRAuthMechanism,
	#superclass : #MongoAuthMechanism,
	#category : 'Mongo-Core-Auth'
}

{ #category : #accessing }
MONGODBCRAuthMechanism class >> description [
	^ 'Challenge Response'
]

{ #category : #accessing }
MONGODBCRAuthMechanism class >> isAbstract [
	^ false
]

{ #category : #operations }
MONGODBCRAuthMechanism >> authenticateUsername: user password: pass forcedDatabase: aDatabase [
	| nonce reply pwd key |
	reply := self root
		command:
			(OrderedIdentityDictionary new
				at: #getnonce put: 1;
				yourself)
		database: aDatabase.
	nonce := reply at: 'nonce'.
	pwd := (MD5 hashMessage: user , ':mongo:' , pass) hex asLowercase.
	key := (MD5 hashMessage: nonce , user , pwd) hex asLowercase.
	[ self root
		command:
			(OrderedIdentityDictionary new
				at: #authenticate put: 1;
				at: #user put: user;
				at: #nonce put: nonce;
				at: #key put: key;
				yourself)
		database: aDatabase ]
		on: MongoCommandError
		do: [ ^ false ].
	^ true
]
