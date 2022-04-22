"
I represent an error ocurred on a query. 

See my class references to better understand.
"
Class {
	#name : #MongoQueryError,
	#superclass : #MongoNativeError,
	#category : 'Mongo-Core-Errors'
}

{ #category : #accessing }
MongoQueryError >> err [
	^ reply at: '$err'
]

{ #category : #accessing }
MongoQueryError >> errorMessage [
	"A more descriptive alias for #err."
	
	^ self err
]

{ #category : #testing }
MongoQueryError >> isNotMasterAndSlaveOkIsFalse [
	"Test if the cause of error was that the mongodb instance belongs to a replica set and it is not the master and slaveOk property is false in the replSetConfig."

	^ self 
		codeIfPresent: [ :code | code = 13435 ] 
		ifAbsent: [ self errmsg = 'not master and slaveOk=false' ]
]
