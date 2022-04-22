"
I represent a Mongo Replica Set configuration. More concretely, I reify the result of config command ( https://docs.mongodb.com/v3.0/reference/command/replSetGetConfig/)
"
Class {
	#name : #MongoReplicaSetConfig,
	#superclass : #Object,
	#instVars : [
		'configuration'
	],
	#category : 'Mongo-Core-Responses'
}

{ #category : #'instance creation' }
MongoReplicaSetConfig class >> with: aDictionary [
	^ self basicNew
		initialize: aDictionary;
		yourself
]

{ #category : #private }
MongoReplicaSetConfig >> config [
	^configuration at: 'config'
]

{ #category : #initialization }
MongoReplicaSetConfig >> initialize: aDictionary [
	self initialize.
	
	configuration := aDictionary.
]

{ #category : #accessing }
MongoReplicaSetConfig >> members [
	^(self config at: 'members')
		collect: [ :each | MongoReplicaSetConfigMember with: each ]
]

{ #category : #accessing }
MongoReplicaSetConfig >> name [
	^self config at: '_id'
]

{ #category : #printing }
MongoReplicaSetConfig >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $).
]
