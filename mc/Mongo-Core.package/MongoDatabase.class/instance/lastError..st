operations
lastError: aWriteConcernOrNil
	"Answer the result of getLastError mongodb command. 
	
	See more: https://docs.mongodb.com/manual/reference/command/getLastError
	"

	| reply command |
	command := OrderedIdentityDictionary new 
		at: 'getLastError' put: 1; 
		yourself.
	aWriteConcernOrNil ifNotNil: [ aWriteConcernOrNil asKeysAndValuesInto: command ].
	reply := self command: command.
	
	^MongoLastError newFor: reply