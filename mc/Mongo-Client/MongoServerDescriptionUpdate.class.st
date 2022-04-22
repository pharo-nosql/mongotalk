"
I'm an announced by a MongoClient when the topology has news from a server.
"
Class {
	#name : #MongoServerDescriptionUpdate,
	#superclass : #MongoClientAnnouncement,
	#instVars : [
		'oldServerDescription',
		'newServerDescription'
	],
	#category : 'Mongo-Client-Announcements'
}

{ #category : #'instance creation' }
MongoServerDescriptionUpdate class >> from: aMongoServerDescription to: anotherMongoServerDescription [
	^ self basicNew
		initializeFrom: aMongoServerDescription
			to: anotherMongoServerDescription;
		yourself
]

{ #category : #initialization }
MongoServerDescriptionUpdate >> initializeFrom: aMongoServerDescription to: anotherMongoServerDescription [ 
	self initialize.	
	oldServerDescription := aMongoServerDescription.
	newServerDescription := anotherMongoServerDescription.
]

{ #category : #accessing }
MongoServerDescriptionUpdate >> newServerDescription [
	^ newServerDescription
]

{ #category : #accessing }
MongoServerDescriptionUpdate >> oldServerDescription [
	^ oldServerDescription
]

{ #category : #printing }
MongoServerDescriptionUpdate >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream nextPutAll: ' changes: '.
	self printRelevantChangesOn: aStream
]

{ #category : #printing }
MongoServerDescriptionUpdate >> printRelevantChangesOn: aStream [
	aStream nextPutAll: '{ '.
	newServerDescription
		differencesFrom: oldServerDescription
		do: [ :selector :diff | 
			aStream
				nextPutAll: selector;
				nextPutAll: ': ';
				print: diff;
				nextPutAll: '. ' ].
	aStream nextPutAll: '}'.

]

{ #category : #printing }
MongoServerDescriptionUpdate >> urlString [
	"Both old and new descriptions correspond to the same server, so also same URL."

	^ newServerDescription urlString
]
