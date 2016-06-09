testing
isNotMaster
	"Test if the cause of error was that the mongodb instance belongs to a replica set and it is not the master in the replSetConfig."

	^ self 
		codeIfPresent: [ :code | code = 10107 ] 
		ifAbsent: [ self errmsg = 'not master' ]