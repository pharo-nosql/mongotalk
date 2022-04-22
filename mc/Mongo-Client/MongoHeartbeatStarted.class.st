"
I'm announced by a MongoClient just before a monitor sends a isMaster command to check the status of a mongodb server.
"
Class {
	#name : #MongoHeartbeatStarted,
	#superclass : #MongoHeartbeat,
	#category : 'Mongo-Client-Announcements'
}

{ #category : #'instance creation' }
MongoHeartbeatStarted class >> urlString: aUrlString [
	^ self basicNew
		initializeWithUrlString: aUrlString;
		yourself
]

{ #category : #initialization }
MongoHeartbeatStarted >> initializeWithUrlString: aUrlString [
	self initialize.

	urlString := aUrlString.
]
