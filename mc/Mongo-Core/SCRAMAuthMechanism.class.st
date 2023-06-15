"
I implement SCRAM-SHA1 auth mechanism
"
Class {
	#name : #SCRAMAuthMechanism,
	#superclass : #MongoAuthMechanism,
	#category : #'Mongo-Core-Auth'
}

{ #category : #testing }
SCRAMAuthMechanism class >> isAbstract [
	^ true
]

{ #category : #operations }
SCRAMAuthMechanism >> authenticateUsername: username password: password forcedDatabase: database [
	| nonce firstBare op resp serverFirst parsed iterations salt rnonce without_proof derivedKey clientKey storedKey authMsg clientSig clientProof clientFinal serverKey serverSig |
	nonce := (Random new next asString allButFirst: 2) asByteArray base64Encoded.
	firstBare := 'n=' , username , ',r=' , nonce.
	op := OrderedIdentityDictionary new
		add: #saslStart -> 1;
		add: #mechanism -> self mechanismName;
		add: #payload -> ('n,,' , firstBare) asByteArray;
		add: #autoAuthorize -> 1;
		yourself.
	resp := [ self root command: op database: database ]
		on: MongoCommandError
		do: [ ^ false ].
	serverFirst := resp at: #payload.
	parsed := self parseScramResponse: serverFirst.
	iterations := parsed at: #i.
	salt := parsed at: #s.
	rnonce := parsed at: #r.
	(rnonce beginsWith: nonce)
		ifFalse: [ ^ false	"Server returned an invalid nonce." ].
	without_proof := 'c=biws,r=' , rnonce.
	derivedKey := MongoPBKDF2 new
		hashFunction: self hashFunction;
		password: (self digestUsername: username password: password);
		salt: salt base64Decoded;
		iterations: iterations asInteger;
		length: 20;
		deriveKey.
	clientKey := (HMAC on: self hashFunction new)
		key: derivedKey;
		digestMessage: 'Client Key'.
	storedKey := self hashFunction hashMessage: clientKey.
	authMsg := ','
		join:
			{firstBare.
			serverFirst.
			without_proof}.
	clientSig := (HMAC on: SHA1 new)
		key: storedKey;
		digestMessage: authMsg.
	clientProof := 'p=' , (clientKey bitXor: clientSig) base64Encoded.
	clientFinal := ','
		join:
			{without_proof.
			clientProof}.
	op := OrderedIdentityDictionary new
		add: #saslContinue -> 1;
		add: #conversationId -> (resp at: #conversationId);
		add: #payload -> clientFinal asByteArray;
		yourself.
	[ resp := self root command: op database: database ]
		on: MongoCommandError
		do: [ ^ false ].
	parsed := self parseScramResponse: (resp at: #payload).
	serverKey := (HMAC on: self hashFunction new)
		key: derivedKey;
		digestMessage: 'Server Key'.
	serverSig := ((HMAC on: self hashFunction new)
		key: serverKey;
		digestMessage: authMsg) base64Encoded.
	(parsed at: #v) = serverSig
		ifFalse: [ ^ false	"Server returned an invalid signature." ].
	(resp at: #done)
		ifFalse: [ op := OrderedIdentityDictionary new
				add: #saslContinue -> 1;
				add: #conversationId -> (resp at: #conversationId);
				add: #payload -> ByteArray new;
				yourself.
			resp := self root command: op database: database.
			^ resp at: #done ].	"ifFalse: SASL conversation failed to complete."
	^ true
]

{ #category : #private }
SCRAMAuthMechanism >> digestUsername: username password: password [
	^ (MD5 hashMessage: username , ':mongo:' , password) hex
]

{ #category : #operations }
SCRAMAuthMechanism >> hashFunction [
	^ self subclassResponsibility
]

{ #category : #operations }
SCRAMAuthMechanism >> mechanismName [
    ^ self subclassResponsibility
]

{ #category : #private }
SCRAMAuthMechanism >> parseScramResponse: payload [
	"
	Parse response from ByteArray to Dictinary
	payload example:
	'r=NDQwNDY0NjUxNDE3MjAzNTM=D06U34OmY+NSiHeqb5LlQQ==,s=xyBf9wy9k94L7Zn+6A6UXg==,i=10000'
	output: { r->'NDQ...'. s->'xy...'. i->10000 } asDictionary"

	^ ((payload asString substrings: ',')
		collect: [ :each | each first asString -> (each copyFrom: 3 to: each size) ])
		asDictionary
]
