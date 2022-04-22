"
I'm announced by a MongoClient just after a monitor failed to get the isMaster response from a mongodb server. I match with a previous MongoHeartbeatStarted announcement.
"
Class {
	#name : #MongoHeartbeatFailed,
	#superclass : #MongoHeartbeat,
	#instVars : [
		'errorDescription'
	],
	#category : 'Mongo-Client-Announcements'
}

{ #category : #'instance creation' }
MongoHeartbeatFailed class >> urlString: aUrlString errorDescription: aString [
	^ self basicNew
		initializeWithUrlString: aUrlString errorDescription: aString;
		yourself
]

{ #category : #accessing }
MongoHeartbeatFailed >> errorDescription [
	^ errorDescription
]

{ #category : #initialization }
MongoHeartbeatFailed >> initializeWithUrlString: aUrlString errorDescription: aString [
	self initialize.
	
	urlString := aUrlString.
	errorDescription := aString.
]
