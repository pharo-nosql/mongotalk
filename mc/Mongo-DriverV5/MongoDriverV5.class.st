"
A driver from mongo wire protocol from v5.0 and later.

https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/
"
Class {
	#name : #MongoDriverV5,
	#superclass : #MongoDriver,
	#category : #'Mongo-DriverV5-Base'
}

{ #category : #testing }
MongoDriverV5 class >> isDefault [

	^ true
]

{ #category : #operations }
MongoDriverV5 >> executeCommand: command [
	| result |

	result := OrderedCollection new.
	command doBlock: [:each | result :=each ].

	(MongoCommand root: self root query: command) execute.

	(result notNil and: [ result includesKey: '$err' ])
		ifTrue: [ ^ MongoQueryError signalFor: result ].

	^ result
]

{ #category : #operations }
MongoDriverV5 >> insert: aDocument inCollection: aMongoCollection inDatabase: aMongoDatabase [
	| command |

	"https://www.mongodb.com/docs/manual/reference/command/insert/#mongodb-dbcommand-dbcmd.insert"
	command := self newCommand: (OrderedDictionary newFromPairs: {
			'insert'. 		aMongoCollection name.
			'documents'.		aDocument
		})
		database: aMongoDatabase
		flags: 0.

	^ self executeCommand: command
]

{ #category : #factory }
MongoDriverV5 >> newCommand: anOrderedDictionary database: aDatabase flags: flags [

	^ MongoQuery new
		operation: OpMsgCommand;
		database: aDatabase;
		where: anOrderedDictionary;
		flags: flags;
		yourself
]

{ #category : #factory }
MongoDriverV5 >> newQuery [

	^ super newQuery 
		operation: OpMsgQuery;
		yourself
]

{ #category : #operations }
MongoDriverV5 >> query: aMongoQuery [
	| results |

	results := OrderedCollection new.
	aMongoQuery doBlock ifNil: [
		aMongoQuery doBlock: [:each | results add: each]].

	(MongoCursor root: self query: aMongoQuery) execute.

	(results isNotEmpty and: [ results first includesKey: '$err' ])
		ifTrue: [ ^ MongoQueryError signalFor: results first ].

	^ results
]

{ #category : #operations }
MongoDriverV5 >> queryOne: aMongoQuery [

	aMongoQuery doBlock: [:each |
		^ (each includesKey: '$err')
			ifTrue: [ MongoQueryError signalFor: each ]
			ifFalse: [ each ] ].

	aMongoQuery chunkSize: 1.

	MongoCursor new
		root: self;
		query: aMongoQuery;
		execute.

	^ nil
]
