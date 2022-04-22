"
I represent  an error ocurred in a Mongo $cmd operation.
"
Class {
	#name : #MongoCommandError,
	#superclass : #MongoNativeError,
	#category : 'Mongo-Core-Errors'
}

{ #category : #accessing }
MongoCommandError >> errmsg [
	^ reply at: 'errmsg'
]

{ #category : #accessing }
MongoCommandError >> errorMessage [
	^ reply at: 'errmsg' ifAbsent: 'unknown'
]

{ #category : #testing }
MongoCommandError >> isCollectionAlreadyExists [
	"Test if the cause of error when adding a collection was that the mongodb instance already has such collection."

	^ self 
		codeIfPresent: [ :code | code = 48 ] 
		ifAbsent: [ self errmsg = 'collection already exists' ]
]

{ #category : #testing }
MongoCommandError >> isInsertionError [
	^ self codeIfPresent: [ :code | code = 11000 ] ifAbsent: [ false ]
]

{ #category : #testing }
MongoCommandError >> isNotMaster [
	"Test if the cause of error was that the mongodb instance belongs to a replica set and it is not the master in the replSetConfig."

	^ self 
		codeIfPresent: [ :code | code = 10107 ] 
		ifAbsent: [ self errmsg = 'not master' ]
]

{ #category : #testing }
MongoCommandError >> isNotMasterAndSlaveOkIsFalse [
	"Test if the cause of error was that the mongodb instance belongs to a replica set and it is not the master and slaveOk property is false in the replSetConfig."

	^ self 
		codeIfPresent: [ :code | code = 13435 ] 
		ifAbsent: [ self errmsg = 'not master and slaveOk=false' ]
]

{ #category : #testing }
MongoCommandError >> isNotRunningWithReplSet [
	"Test if the cause of error was that the mongodb instance was not ran with --replSet argument, which is needed to perform replication operations."

	^ self 
		codeIfPresent: [ :code | code = 76 ] 
		ifAbsent: [ self errmsg = 'not running with --replSet' ]
]
