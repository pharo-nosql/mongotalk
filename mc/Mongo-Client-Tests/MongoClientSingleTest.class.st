Class {
	#name : #MongoClientSingleTest,
	#superclass : #MongoClientTest,
	#category : 'Mongo-Client-Tests'
}

{ #category : #'tests - monitoring' }
MongoClientSingleTest >> testFindInitialPrimary [

	| topology |
	client := self newClient.
	self startClientAndWait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeSingle.
	self assert: topology primaryUrl equals: self urlToTest.

]

{ #category : #'tests - discovering' }
MongoClientSingleTest >> testInitialTopologyIsUnknown [

	client := self newClient.
	self assert: client topology isTypeUnknown.
	client start.
	self assert: client topology isTypeUnknown.
	10 milliSeconds wait.
	self deny: client topology isTypeUnknown.

]

{ #category : #'tests - monitoring' }
MongoClientSingleTest >> testUpdateAnnouncements [
	
	| serverUpdates topologyUpdates heartbeatSucceeded heartbeatStarted numberOfServers |
	client := self newClient.
	numberOfServers := 1.

	heartbeatStarted := SharedQueue new.
	client announcer
		when: MongoHeartbeatStarted
		send: #nextPut:
		to: heartbeatStarted.

	heartbeatSucceeded := SharedQueue new.
	client announcer
		when: MongoHeartbeatSucceeded
		send: #nextPut:
		to: heartbeatSucceeded.

	serverUpdates := SharedQueue new.
	client announcer
		when: MongoServerDescriptionUpdate
		send: #nextPut:
		to: serverUpdates.

	topologyUpdates := SharedQueue new.
	client announcer
		when: MongoTopologyUpdate
		send: #nextPut:
		to: topologyUpdates.
	
	self startClientAndWait.

	(1 to: 4)
		do: [ :each |
			self assert: client topology servers size equals: numberOfServers.
			self assert: heartbeatStarted size >= (each * numberOfServers).
			self assert: heartbeatSucceeded size >= (each * numberOfServers).
			self assert: serverUpdates size equals: numberOfServers.
			self assert: topologyUpdates size equals: 1 ]
		separatedBy: [ client settings heartbeatFrequency wait ]

]

{ #category : #running }
MongoClientSingleTest >> urlToTest [
	^ 'localhost:27017' asMongoUrl
]

{ #category : #running }
MongoClientSingleTest >> urlsToTest [
	^ { self urlToTest }
]
