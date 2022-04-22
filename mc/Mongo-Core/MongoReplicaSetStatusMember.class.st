"
I represent a member of a Mongo Replica Set status. More concretely, I reify part of the result of status command (https://docs.mongodb.com/v3.0/reference/command/replSetGetStatus)
"
Class {
	#name : #MongoReplicaSetStatusMember,
	#superclass : #Object,
	#instVars : [
		'status'
	],
	#category : 'Mongo-Core-Responses'
}

{ #category : #'instance creation' }
MongoReplicaSetStatusMember class >> with: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #accessing }
MongoReplicaSetStatusMember >> host [
	| colonPosition |
	colonPosition := self name indexOf: $:.

	^self name first: colonPosition-1
]

{ #category : #initialization }
MongoReplicaSetStatusMember >> initialize: aConfiguration [
	self initialize.
	
	status := aConfiguration.
]

{ #category : #testing }
MongoReplicaSetStatusMember >> isArbiterOnly [
	^status at: 'arbiterOnly'
]

{ #category : #testing }
MongoReplicaSetStatusMember >> isPrimary [ 
	^self state = 1
]

{ #category : #testing }
MongoReplicaSetStatusMember >> isSecondary [
	^self state = 2
]

{ #category : #accessing }
MongoReplicaSetStatusMember >> name [
	^status at: 'name'
]

{ #category : #accessing }
MongoReplicaSetStatusMember >> port [
	| colonPosition |
	colonPosition := self name indexOf: $:.

	^(self name allButFirst: colonPosition) asInteger
]

{ #category : #printing }
MongoReplicaSetStatusMember >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
]

{ #category : #accessing }
MongoReplicaSetStatusMember >> state [
	^status at: 'state'
]

{ #category : #accessing }
MongoReplicaSetStatusMember >> stateString [
	^status at: 'stateStr'
]
