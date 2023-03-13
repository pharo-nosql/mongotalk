"
Access to Mongo

Instance Variables
	authCache:		<Object>
	host:		<Object>
	port:		<Object>
	requestID:		<Object>
	stream:		<Object>

authCache
	- xxxxx

host
	- xxxxx

port
	- xxxxx

requestID
	- xxxxx

stream
	- xxxxx

"
Class {
	#name : #Mongo,
	#superclass : #Object,
	#instVars : [
		'host',
		'port',
		'stream',
		'requestID',
		'authMechanism',
		'authCache',
		'driver'
	],
	#classVars : [
		'Default'
	],
	#classInstVars : [
		'defaultAuthMechanismClass'
	],
	#category : #'Mongo-Core-Base'
}

{ #category : #constants }
Mongo class >> ascending [
	"Ascending sort order"
	
	^1
]

{ #category : #accessing }
Mongo class >> default [
	"If there is no other default use the local one"
	
	^Default ifNil: [ Default := self local ]
]

{ #category : #accessing }
Mongo class >> default: aMongo [
	"Ability to set an own default"
	
	Default := aMongo
]

{ #category : #accessing }
Mongo class >> defaultAuthMechanismClass [
	"Answer a subclass of MongoAuthMechanism that represents the default authentication mechanism for a Mongo instance.
	
	See: https://docs.mongodb.com/v4.0/core/authentication-mechanisms/
	"

	^ defaultAuthMechanismClass ifNil: [ SCRAMSHA1AuthMechanism ]
]

{ #category : #accessing }
Mongo class >> defaultAuthMechanismClass: class [
	defaultAuthMechanismClass := class
]

{ #category : #constants }
Mongo class >> descending [
	"Descending sort order"
	
	^-1
]

{ #category : #'instance creation' }
Mongo class >> host: aString port: anInteger [
	"Return a new instance on the given server and port"
	
	^self new setHost: aString port: anInteger
]

{ #category : #'instance creation' }
Mongo class >> local [
	"Return the standard locally running MongoDB server instance"
	
	^self host: 'localhost' port: 27017
]

{ #category : #'instance creation' }
Mongo class >> url: aZnUrl [
	"Return a new instance on the given URL"

	^ self new setHost: aZnUrl host port: aZnUrl port
]

{ #category : #private }
Mongo >> admin [
	^self databaseNamed: 'admin'
]

{ #category : #accessing }
Mongo >> authCache [
	^ authCache ifNil: [ 
		authCache := Dictionary new ]
]

{ #category : #accessing }
Mongo >> authMechanism [
	^ authMechanism ifNil: [ authMechanism := self class defaultAuthMechanismClass root: self ]
]

{ #category : #accessing }
Mongo >> authMechanism: aMongoAuthMechanism [
	authMechanism := aMongoAuthMechanism
]

{ #category : #operations }
Mongo >> authenticateUsername: user password: pass database: aDatabase [

	^self authMechanism 
		authenticateUsername: user 
		password: pass 
		database: aDatabase
]

{ #category : #operations }
Mongo >> close [
	stream close
]

{ #category : #operations }
Mongo >> closeIfOpen [
	self isOpen ifTrue: [ self close ]
]

{ #category : #operations }
Mongo >> command: anOrderedDictionary database: aDatabase [

	^ self
		command: anOrderedDictionary
		database: aDatabase
		flags: 0
]

{ #category : #operations }
Mongo >> command: anOrderedDictionary database: aDatabase flags: flags [
	| query reply |

	query := self
		newQueryCommand: anOrderedDictionary
		database: aDatabase
		flags: flags.
	reply := self driver executeCommand: query.

	(reply at: 'ok' ifAbsent: [ self error ]) = 1.0
		ifFalse: [ MongoCommandError signalFor: reply ].

	^ reply
]

{ #category : #operations }
Mongo >> databaseNamed: aString [
	^MongoDatabase root: self name: aString
]

{ #category : #operations }
Mongo >> databaseNames [
	^ self listDatabases collect: [:each | each at: 'name' ]
]

{ #category : #operations }
Mongo >> databases [
	^ self databaseNames collect: [ :each | self databaseNamed: each ]
]

{ #category : #'private - communicating' }
Mongo >> delete: aDictionary collection: aCollection [

	self driver
		delete: aDictionary
		collection: aCollection
]

{ #category : #private }
Mongo >> driver [

	^ driver ifNil: [
		(driver := MongoDriver newDefault)
			root: self;
			yourself ]
]

{ #category : #accessing }
Mongo >> host [
	^host
]

{ #category : #'private - communicating' }
Mongo >> insert: aDocument collection: aMongoCollection [

	self driver
		insert: aDocument
		collection: aMongoCollection
]

{ #category : #testing }
Mongo >> isAvailable [
	"Return true when it is possible to connect to the mongo DB instance, false otherwise.
	 When it is available it is also opened."
	
	^[self open isOpen ]
		on: ConnectionTimedOut
		do: [ ^false ]
]

{ #category : #operations }
Mongo >> isMaster [
	^ self admin isMaster
]

{ #category : #testing }
Mongo >> isOpen [ 
	^stream notNil and: [ stream isConnected ]
]

{ #category : #operations }
Mongo >> listDatabases [
	| command |
	command := (OrderedIdentityDictionary new)
				at: #listDatabases put: 1;
				yourself.
	^ (self admin command: command) at: 'databases'
]

{ #category : #accessing }
Mongo >> majorVersion [
	"Get the mongodb instance major version (e.g. 2 or 3) as integer. See #version"

	^ (self version splitOn: '.') first asInteger
]

{ #category : #factory }
Mongo >> newQuery [

	^ self driver newQuery
]

{ #category : #factory }
Mongo >> newQueryCommand: anOrderedDictionary  database: aDatabase flags: flags [

	^ self driver
		newQueryCommand: anOrderedDictionary
		database: aDatabase
		flags: flags
]

{ #category : #private }
Mongo >> nextRequestID [

	^ requestID := requestID + 1 bitAnd: 16r3FFFFFFF
]

{ #category : #operations }
Mongo >> open [

	stream := SocketStream openConnectionToHostNamed: host port: port.
	stream binary.
	stream socket 
		setOption: 'TCP_NODELAY' 
		value: 1.
	authCache := nil
]

{ #category : #operations }
Mongo >> openWithTimeout: aDuration [
	| addr |
	"Waits the specified number of seconds to open the connection."
	addr := NetNameResolver addressForName: host timeout: 20.
	stream := SocketStream openConnectionToHost: addr port: port timeout: aDuration asSeconds.
	stream socket setOption: 'TCP_NODELAY' value: 1.
	stream binary.
	authCache := nil
]

{ #category : #accessing }
Mongo >> port [

	^ port
]

{ #category : #printing }
Mongo >> printOn: aStream [

	aStream 
		nextPutAll: 'Mongo (';
		nextPutAll: host asString;
		nextPut: $:;
		nextPutAll: port asString;
		nextPut: $)
]

{ #category : #operations }
Mongo >> query: aMongoQuery [

	^ self driver query: aMongoQuery
]

{ #category : #operations }
Mongo >> queryOne: aMongoQuery [

	^ self driver queryOne: aMongoQuery
]

{ #category : #operations }
Mongo >> replicaSetConfig [
	"Answer the configuration of the replica set.
	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetGetConfig/"

	^ self admin replicaSetConfig
]

{ #category : #operations }
Mongo >> replicaSetStatus [
	"Answer the status of the replica set.
	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetGetStatus/"

	^ self admin replicaSetStatus
]

{ #category : #operations }
Mongo >> replicaSetStepDown: aDuration [
	"Forces the primary of the replica set to become a secondary, triggering an election for primary. The command steps down the primary for a specified number of seconds; during this period, the stepdown member is ineligible from becoming primary.

	Command supported since mongodb 3.0. See more at:
	https://docs.mongodb.com/v3.0/reference/command/replSetStepDown/"

	"This command produces a connection close. We'll re-open. Same behavior as in mongo shell... too smart?"
	[ self admin command: {('replSetStepDown' -> aDuration asSeconds)} asDictionary ]
		on: ConnectionClosed
		do: [ self isOpen ifFalse: [ self open ] ]

]

{ #category : #private }
Mongo >> setHost: aString port: anInteger [
	requestID := 0.
	host := aString.
	port := anInteger.
	"validate?"
]

{ #category : #accessing }
Mongo >> socketTimeout: aDuration [
	"Set the timeout for next queries and commands to execute."

	stream timeout: aDuration asSeconds
]

{ #category : #accessing }
Mongo >> stream [

	^ stream
]

{ #category : #accessing }
Mongo >> stream: aStream [

	stream := aStream.
	authCache := nil
]

{ #category : #'private - communicating' }
Mongo >> update: origDictionary with: newDictionary collection: aMongoCollection [

	^ self
		update: origDictionary
		with: newDictionary
		collection: aMongoCollection
		upsert: false
		multi: false
]

{ #category : #'private - communicating' }
Mongo >> update: origDictionary with: newDictionary collection: aMongoCollection upsert: upsertBoolean multi: multiBoolean [

	self driver
		update: origDictionary
		with: newDictionary
		collection: aMongoCollection
		upsert: upsertBoolean
		multi: multiBoolean
]

{ #category : #accessing }
Mongo >> urlString [
	^ host asString, ':', port asString
]

{ #category : #accessing }
Mongo >> useDriver: aDriver [

	driver := aDriver.
	aDriver connection: self
]

{ #category : #operations }
Mongo >> username: aUserString password: aPasswordString database: aDatabase [
	"authenticate a user for a database. MongoDB needs authentication only once 
	every connection/session per database/user combination. So in order not to slow
	down things we cache the authentication setting. Note: A second authentication for
	a database with a different user invalidates the first auth. That's why the authCache
	stores only on username per database"
	| authenticatedUser |
	authenticatedUser := self authCache at: aDatabase name ifAbsent: [ nil ].
	(authenticatedUser isNil or: [  (authenticatedUser = aUserString) not ]) ifTrue: [ 
		(self 
			authenticateUsername: aUserString 
			password: aPasswordString 
			database: aDatabase) ifTrue: [ 
				self authCache at: aDatabase name put: aUserString ] ]
]

{ #category : #accessing }
Mongo >> version [
	"Get the mongodb instance vrsion. The result is obtained via `buildInfo` command. 
	See more: https://docs.mongodb.com/manual/reference/command/buildInfo/"
	| buildInfo |
	
	buildInfo := self admin command: {'buildInfo' -> 1.0} asDictionary.
	^ buildInfo at: 'version'
]
