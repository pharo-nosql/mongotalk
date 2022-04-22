Class {
	#name : #MongoClientMonitoringTest,
	#superclass : #MongoClientReplicaSetTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #tests }
MongoClientMonitoringTest >> testFindInitialPrimary [

	| topology |
	client := self newClient.
	self startClientAndWait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

]

{ #category : #tests }
MongoClientMonitoringTest >> testFindPrimaryAfterSIGCONT [

	| topology |
	client := self newClient.
	self startClientAndWait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	MongoReplicationTestResources signalStopA.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Server B is elected as primary (the only electable, since C has zero priority)"
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.

	MongoReplicationTestResources continueAllServers.
	self waitMonitorsHeartbeatAndTimeout.

	"A is up again and the new primary (it has higher priority than B)."
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

]

{ #category : #tests }
MongoClientMonitoringTest >> testFindPrimaryAfterSIGSTOP [

	| topology |
	client := self newClient.
	self startClientAndWait.

	MongoReplicationTestResources signalStopA.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Server B is elected as primary (the only electable, since C has zero priority)"
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.

]

{ #category : #tests }
MongoClientMonitoringTest >> testFindPrimaryAfterStepDown [

	| topology |
	client := self newClient.
	self startClientAndWait.

	MongoReplicationTestResources stepDownA: 10 seconds.
	
	"Wait a bit (client's heartbeatFrequency should be enough)"
	9.5 seconds wait.

	"Server B is elected as primary (the only electable, since C has zero priority)"
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.

]

{ #category : #tests }
MongoClientMonitoringTest >> testUpdateAnnouncements [
	
	| serverUpdates topologyUpdates heartbeatSucceeded heartbeatStarted |
	client := self newClient.

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
			self assert: client topology servers size equals: 3.
			self assert: heartbeatStarted size >= (each * 3).
			self assert: heartbeatSucceeded size >= (each * 3).
			self assert: serverUpdates size >= 3.
			self assert: topologyUpdates size >= 1 ]
		separatedBy: [ client settings heartbeatFrequency wait ]

]
