"
I'm an announced by a MongoClient when it's topology was updated (replaced).
"
Class {
	#name : #MongoTopologyUpdate,
	#superclass : #MongoClientAnnouncement,
	#instVars : [
		'oldTopology',
		'newTopology'
	],
	#category : 'Mongo-Client-Announcements'
}

{ #category : #'instance creation' }
MongoTopologyUpdate class >> from: aMongoServerDescription to: anotherMongoServerDescription [
	^ self basicNew
		initializeFrom: aMongoServerDescription
			to: anotherMongoServerDescription;
		yourself
]

{ #category : #initialization }
MongoTopologyUpdate >> initializeFrom: aMongoTopology to: anotherMongoTopology [
	self initialize.
	oldTopology := aMongoTopology.
	newTopology := anotherMongoTopology.
]

{ #category : #accessing }
MongoTopologyUpdate >> newTopology [
	^ newTopology
]

{ #category : #accessing }
MongoTopologyUpdate >> oldTopology [
	^ oldTopology
]

{ #category : #printing }
MongoTopologyUpdate >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream nextPutAll: ' changes: '.
	self printRelevantChangesOn: aStream
]

{ #category : #printing }
MongoTopologyUpdate >> printRelevantChangesOn: aStream [
	aStream nextPutAll: '{ '.
	newTopology
		differencesFrom: oldTopology
		do: [ :selector :diff | 
			aStream
				nextPutAll: selector;
				nextPutAll: ': ';
				print: diff;
				nextPutAll: '. ' ].
	aStream nextPutAll: '}'.

]
