"
I'm announced by a MongoClient just after a monitor got the isMaster response from a mongodb server. I match with a previous MongoHeartbeatStarted announcement.
"
Class {
	#name : #MongoHeartbeatSucceeded,
	#superclass : #MongoHeartbeat,
	#instVars : [
		'isMaster',
		'roundTripTimeDuraton'
	],
	#category : 'Mongo-Client-Announcements'
}

{ #category : #'instance creation' }
MongoHeartbeatSucceeded class >> urlString: aUrlString roundtripTimeDuraton: aDuration isMaster: aMongoIsMaster [
	^ self basicNew
		initializeWithUrlString: aUrlString
			roundTripTimeDuraton: aDuration
			isMaster: aMongoIsMaster;
		yourself
]

{ #category : #accessing }
MongoHeartbeatSucceeded >> initializeWithUrlString: aUrlString roundTripTimeDuraton: aDuration isMaster: aMongoIsMaster [
	self initialize.
	
	urlString := aUrlString.
	roundTripTimeDuraton := aDuration.
	isMaster := aMongoIsMaster.
]

{ #category : #accessing }
MongoHeartbeatSucceeded >> isMaster [
	^ isMaster
]

{ #category : #accessing }
MongoHeartbeatSucceeded >> roundTripTimeDuraton [
	^ roundTripTimeDuraton
]
