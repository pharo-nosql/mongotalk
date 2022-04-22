"
I represent a member of a Mongo Replica Set configuration. More concretely, I reify part of the result of config command (https://docs.mongodb.com/v3.0/reference/command/replSetGetConfig/)
"
Class {
	#name : #MongoReplicaSetConfigMember,
	#superclass : #Object,
	#instVars : [
		'configuration'
	],
	#category : 'Mongo-Core-Responses'
}

{ #category : #'instance creation' }
MongoReplicaSetConfigMember class >> with: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #initialization }
MongoReplicaSetConfigMember >> initialize: aConfiguration [
	self initialize.
	
	configuration := aConfiguration.
]

{ #category : #testing }
MongoReplicaSetConfigMember >> isArbiterOnly [
	^(configuration at: 'arbiterOnly') "= 'true'"
]

{ #category : #accessing }
MongoReplicaSetConfigMember >> name [
	^configuration at: 'host'
]

{ #category : #printing }
MongoReplicaSetConfigMember >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
]

{ #category : #accessing }
MongoReplicaSetConfigMember >> priority [
	^(configuration at: 'priority') asNumber
]

{ #category : #accessing }
MongoReplicaSetConfigMember >> tags [
	^configuration at: 'tags'
]

{ #category : #accessing }
MongoReplicaSetConfigMember >> votes [
	^configuration at: 'votes'
]
