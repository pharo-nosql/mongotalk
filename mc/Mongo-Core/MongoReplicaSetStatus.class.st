"
I represent a Mongo Replica Set status. More concretely, I reify the result of status command ( https://docs.mongodb.com/v3.0/reference/command/replSetGetStatus/)
"
Class {
	#name : #MongoReplicaSetStatus,
	#superclass : #Object,
	#instVars : [
		'status'
	],
	#category : 'Mongo-Core-Responses'
}

{ #category : #'instance creation' }
MongoReplicaSetStatus class >> with: aDictionary [
	^ self basicNew
		initialize: aDictionary;
		yourself
]

{ #category : #initialization }
MongoReplicaSetStatus >> initialize: aDictionary [
	self initialize.

	status := aDictionary.
]

{ #category : #accessing }
MongoReplicaSetStatus >> members [
	^(status at: 'members')
		collect: [ :each | MongoReplicaSetStatusMember with: each ]
]

{ #category : #accessing }
MongoReplicaSetStatus >> name [
	^status at: 'set'
]

{ #category : #accessing }
MongoReplicaSetStatus >> primaryMember [
	^self members detect: #isPrimary
]

{ #category : #printing }
MongoReplicaSetStatus >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
]
