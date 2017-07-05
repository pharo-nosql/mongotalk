operations
authenticateUsername: user password: pass forcedDatabase: aDatabase
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