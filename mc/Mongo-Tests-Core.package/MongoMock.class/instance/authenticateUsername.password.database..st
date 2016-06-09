operations
authenticateUsername: user password: pass database: aDatabase
	authCalls := authCalls + 1.
	^ succeedAuth 