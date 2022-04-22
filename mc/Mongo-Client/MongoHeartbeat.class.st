"
My subclasses are announced by a MongoClient when the monitors check the status of MongoDB servers.
"
Class {
	#name : #MongoHeartbeat,
	#superclass : #MongoClientAnnouncement,
	#instVars : [
		'urlString'
	],
	#category : 'Mongo-Client-Announcements'
}

{ #category : #printing }
MongoHeartbeat >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' url: ';
		print: urlString
]

{ #category : #accessing }
MongoHeartbeat >> urlString [
	^ urlString
]
