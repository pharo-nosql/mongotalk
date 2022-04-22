"
I provide the protocol to initialize a replica set scenario for testing purposes.

"
Class {
	#name : #MongoTestReplicaSet,
	#superclass : #Object,
	#instVars : [
		'servers',
		'memberDescriptions',
		'settingsDictionary',
		'replicaSetName'
	],
	#category : 'Mongo-Tests-ReplicaSet'
}

{ #category : #initialization }
MongoTestReplicaSet >> addMember: idNumber port: portNumber priority: priorityNumber [
	"Specify a mongod that will be started on #start. All arguments must be numbers. Precondition: self is not started.
	
	See: https://docs.mongodb.com/v4.0/reference/replica-configuration/#members"
	
	memberDescriptions add: {
		 	'_id' -> idNumber.
			'host' -> ('localhost:', portNumber asString).
			'priority' -> priorityNumber
		} asOrderedDictionary.
		
	servers add: (MongoTestServer new
			port: portNumber;
			replicaSetName: replicaSetName;
			yourself)
]

{ #category : #operations }
MongoTestReplicaSet >> ensureAllServersStarted [
	"Ensure that each server is individually started (#initiateReplicaSet must be sent by separate)."

	servers
		do: [ :each | each ensureStarted ];
		do: [ :each | each waitIsWrittable ].

]

{ #category : #operations }
MongoTestReplicaSet >> ensureAllServersTerminated [
	servers do: [ :each | each ensureTerminated ]
]

{ #category : #initialization }
MongoTestReplicaSet >> initialize [
	super initialize.
	
	replicaSetName := 'rs-test'.
	memberDescriptions := OrderedCollection new.
	servers := OrderedCollection new.
	settingsDictionary := Dictionary new.
]

{ #category : #operations }
MongoTestReplicaSet >> initiateReplicaSet [
	"Send a replSetInitiate command to configure the replica set. Before, servers are independent and don't know each other. Note: It's required that servers are started, as a precondition.
	
	See: https://docs.mongodb.com/v4.0/reference/replica-configuration"

	servers first mongoDo: [ :mongo |
		mongo admin replSetInitiate: {
			'_id' -> self replicaSetName.
			'protocolVersion' -> 1.
			'members' -> memberDescriptions asArray.
			'settings' -> settingsDictionary
		} asOrderedDictionary ]

]

{ #category : #accessing }
MongoTestReplicaSet >> replicaSetName [
	^ replicaSetName
]

{ #category : #initialization }
MongoTestReplicaSet >> replicaSetName: aString [
	replicaSetName := aString
]

{ #category : #accessing }
MongoTestReplicaSet >> serverAtUrl: aZnUrl [
	^ servers detect: [ :each | each url = aZnUrl ]
]

{ #category : #accessing }
MongoTestReplicaSet >> servers [
	^ servers
]

{ #category : #initialization }
MongoTestReplicaSet >> settingsDictionary: aDictionary [
	"Set a dictionary of settings for the replSetInitiate command.

	See: https://docs.mongodb.com/v4.0/reference/replica-configuration/#settings.
	
	An example dictionary:
		{
			'electionTimeoutMillis' -> 5000.
			'heartbeatTimeoutSecs' -> 5.
		} asOrderedDictionary
	"

	settingsDictionary := aDictionary
]
