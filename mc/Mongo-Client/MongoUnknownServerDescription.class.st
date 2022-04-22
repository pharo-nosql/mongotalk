"
I represent the description of a server that has never connected yet. (Kind of Null Object design pattern implementation).
"
Class {
	#name : #MongoUnknownServerDescription,
	#superclass : #MongoAbstractServerDescription,
	#category : 'Mongo-Client-Topology'
}

{ #category : #'instance creation' }
MongoUnknownServerDescription class >> urlString: urlString [
	^ self basicNew
		initializeUrlString: urlString;
		yourself
]
