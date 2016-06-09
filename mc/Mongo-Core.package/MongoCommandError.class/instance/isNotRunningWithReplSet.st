testing
isNotRunningWithReplSet
	"Test if the cause of error was that the mongodb instance was not ran with --replSet argument, which is needed to perform replication operations."

	^ self 
		codeIfPresent: [ :code | code = 76 ] 
		ifAbsent: [ self errmsg = 'not running with --replSet' ]