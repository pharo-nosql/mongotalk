"
I represent commands can be sent to $cmd collection. I'm almost a ""query operation"" except for simpler format of request.
"
Class {
	#name : #CommandOperation,
	#superclass : #QueryOperation,
	#category : 'Mongo-Core-Operations'
}

{ #category : #writing }
CommandOperation >> computeDataBytes [
	^BSON writer 
		nextOrderedDictionaryPut: mongoQuery where; 
		contents
]
