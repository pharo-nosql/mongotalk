testing
isNotMasterAndSlaveOkIsFalse
	"Test if the cause of error was that the mongodb instance belongs to a replica set and it is not the master and slaveOk property is false in the replSetConfig."

	^ self 
		codeIfPresent: [ :code | code = 13435 ] 
		ifAbsent: [ self errmsg = 'not master and slaveOk=false' ]