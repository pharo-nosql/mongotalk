operations
username: aUserString password: aPasswordString database: aDatabase
	"authenticate a user for a database. MongoDB needs authentication only once 
	every connection/session per database/user combination. So in order not to slow
	down things we cache the authentication setting. Note: A second authentication for
	a database with a different user invalidates the first auth. That's why the authCache
	stores only on username per database"
	| authenticatedUser |
	authenticatedUser := self authCache at: aDatabase name ifAbsent: [ nil ].
	(authenticatedUser isNil or: [  (authenticatedUser = aUserString) not ]) ifTrue: [ 
		(self 
			authenticateUsername: aUserString 
			password: aPasswordString 
			database: aDatabase) ifTrue: [ 
				self authCache at: aDatabase name put: aUserString ] ]