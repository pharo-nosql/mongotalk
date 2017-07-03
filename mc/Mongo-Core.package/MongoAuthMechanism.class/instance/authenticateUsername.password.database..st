operations
authenticateUsername: user password: pass database: aDatabase
	^self authenticateUsername: user password: pass forcedDatabase: (self forceDatabase ifNil: [ aDatabase ])