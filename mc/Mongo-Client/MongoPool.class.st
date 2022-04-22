"
A pool of Mongo instances.

I use a mutex to synchronize manipulation of connections (my collection of Mongo instances).

Source: https://github.com/mongodb/specifications/blob/03aed6c58dcd6afd81980876be2042afc45d06d3/source/connection-monitoring-and-pooling/connection-monitoring-and-pooling.rst

"
Class {
	#name : #MongoPool,
	#superclass : #Object,
	#instVars : [
		'connections',
		'url',
		'mutex',
		'settings'
	],
	#category : 'Mongo-Client-Client'
}

{ #category : #'instance creation' }
MongoPool class >> url: aZnUrl maxConnections: aQuantity connectTimeout: aConnectTimeout socketTimeout: aSocketTimeout [
	^ self basicNew
		initializeUrl: aZnUrl
			maxConnections: aQuantity
			connectTimeout: aConnectTimeout
			socketTimeout: aSocketTimeout;
		yourself
]

{ #category : #'instance creation' }
MongoPool class >> url: aZnUrl settings: aMongoSettings [
	^ self basicNew
		initializeUrl: aZnUrl
			settings: aMongoSettings;
		yourself
]

{ #category : #accessing }
MongoPool >> ensureCloseMongo: aMongo [
	aMongo closeIfOpen
]

{ #category : #private }
MongoPool >> ensureOpenMongo: mongo [
	mongo isOpen ifTrue: [ ^ self ].
	mongo openWithTimeout: settings connectTimeout.
	mongo socketTimeout: settings socketTimeout.
]

{ #category : #initialization }
MongoPool >> initializeUrl: aZnUrl settings: aMongoSettings [
	self initialize.

	url := aZnUrl.
	settings := aMongoSettings.

	mutex := Mutex new.
	connections := LinkedList new.

	self resetAll.

]

{ #category : #accessing }
MongoPool >> mongoDo: aBlockClosure [
	"Evaluate the BlockClosure with a Mongo instance. See #next.
	
	For error handling, the specification states that the client MUST clear its connection pool 
	for the server: if one socket is bad, it is likely that all are.

	Source: https://github.com/mongodb/specifications/blob/573b1f58a129056d651781ad99317b6c656e050e/source/server-discovery-and-monitoring/server-discovery-and-monitoring-summary.rst#id9
	"

	| mongo failed |
	failed := false.
	mongo := self next.
	^ [	
		[ aBlockClosure value: mongo ]
			on: NetworkError, MongoWireProtocolError
			do: [ :error |
				failed := true.
				self ensureCloseMongo: mongo.
				self resetAll.
				error pass ] ]
		ensure: [ 
			"Use ensurce block here because aBlockClosure could have a non local 
			return which would skip returning the connection. So we only return 
			if the prior exception handler did not mark this as failed"
			failed ifFalse: [ 
				self return: mongo ] ]
]

{ #category : #private }
MongoPool >> next [
	"Answer an instance of Mongo that is open (and then ready to be used). The instance may be either one cached from from the pool or a new one if there isn't any cached.
	
	IMPORTANT: When caller is done with the Mongo instance, it must either release it to this pool (see #return:) or close it (since it references an open Socket... else the Pharo image can run out of external semaphores)."

	| mongo |
	mutex critical: [
		mongo := connections
			ifEmpty: [ Mongo url: url ]
			ifNotEmpty: [ connections removeFirst ] ].

	"Caller assumes it's open."
	self ensureOpenMongo: mongo.

	^ mongo
]

{ #category : #accessing }
MongoPool >> resetAll [
	"Remove and close all connections."
	
	mutex critical: [
		[ connections isEmpty ] whileFalse: [
			self ensureCloseMongo: connections removeLast ] ]
]

{ #category : #private }
MongoPool >> return: mongo [
	"Release to this pool an instance of Mongo previously obtained via #next. Ideally, such Mongo instance should be open and ready to be answered by #next on a new operation."

	mutex critical: [
		connections size >= settings maxConnections
			ifTrue: [ self ensureCloseMongo: mongo ]
			ifFalse: [ connections add: mongo ] ]
]

{ #category : #accessing }
MongoPool >> settings [
	^ settings
]
