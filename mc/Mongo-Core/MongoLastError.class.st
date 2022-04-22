"
I represent the answer of mongodb's getLastError command. 

See more: https://docs.mongodb.org/manual/reference/command/getLastError/
"
Class {
	#name : #MongoLastError,
	#superclass : #MongoNativeError,
	#category : 'Mongo-Core-Errors'
}

{ #category : #accessing }
MongoLastError >> err [
	"Error message. See: https://docs.mongodb.com/manual/reference/command/getLastError/#getLastError.err"
	
	^ reply at: 'err'
]

{ #category : #accessing }
MongoLastError >> errorMessage [
	"A more descriptive alias for #err."
	
	^ self err
]

{ #category : #testing }
MongoLastError >> isNotMaster [
	"A 'not master' error can be raised on insert operations."
	
	^ self codeIfPresent: [ :code | code = 10058 ] ifAbsent: [ false ]
]

{ #category : #testing }
MongoLastError >> isNotPrimary [
	"A 'Not primary while performing...' error can be raised on update and remove operations."

	^ self codeIfPresent: [ :code | code = 10107 ] ifAbsent: [ false ]

]

{ #category : #accessing }
MongoLastError >> n [
	"See https://docs.mongodb.com/manual/reference/command/getLastError/#getLastError.n"
	
	^ reply at: 'n'
]

{ #category : #accessing }
MongoLastError >> numberOfMatchedDocuments [
	"A more descriptive alias for #n."
	
	^ self n
]

{ #category : #accessing }
MongoLastError >> ok [
	^ (reply at: 'ok') = 1.0
]
