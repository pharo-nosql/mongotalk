"
I'm the abstract superclass of all MongoClient announcements.

See: https://github.com/mongodb/specifications/blob/master/source/server-discovery-and-monitoring/server-discovery-and-monitoring-monitoring.rst#events
"
Class {
	#name : #MongoClientAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'microsecondTimestamp'
	],
	#category : 'Mongo-Client-Announcements'
}

{ #category : #initialization }
MongoClientAnnouncement >> initialize [
	super initialize.
	
	microsecondTimestamp := Time microsecondClockValue.
]

{ #category : #accessing }
MongoClientAnnouncement >> microsecondTimestamp [
	^ microsecondTimestamp
]

{ #category : #printing }
MongoClientAnnouncement >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' microsecondTimestamp: ';
		print: microsecondTimestamp.

]
