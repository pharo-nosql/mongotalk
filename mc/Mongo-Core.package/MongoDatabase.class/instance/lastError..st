operations
lastError: aWriteConcernOrNil
	"Answer the result of getLastError mongodb command. 
	
	See more: https://docs.mongodb.com/manual/reference/command/getLastError
	"

	| reply command |
	command := { 'getLastError'->1 } asDictionary.
	aWriteConcernOrNil ifNotNil: [ aWriteConcernOrNil asKeysAndValuesInto: command ].
	reply := self command: command.
	
	^MongoLastError newFor: reply