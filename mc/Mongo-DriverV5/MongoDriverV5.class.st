"
A driver from mongo wire protocol from v5.0 and later.

https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/
"
Class {
	#name : 'MongoDriverV5',
	#superclass : 'MongoDriver',
	#traits : 'MongoTSocket',
	#classTraits : 'MongoTSocket classTrait',
	#category : 'Mongo-DriverV5-Base',
	#package : 'Mongo-DriverV5',
	#tag : 'Base'
}

{ #category : 'testing' }
MongoDriverV5 class >> isDefault [

	^ true
]

{ #category : 'accessing' }
MongoDriverV5 >> commandClass [

	^ MongoCursorCommand
]

{ #category : 'accessing' }
MongoDriverV5 >> commandQueryClass [

	^ MongoCursorQuery
]

{ #category : 'private' }
MongoDriverV5 >> cursorQuery: aQuery [
	| id |

	id := self nextRequestID.
	(aQuery operation
		id: id
			stream: self stream
			query: aQuery)
		flags: aQuery flags;
		write.

	^ id
]

{ #category : 'operations' }
MongoDriverV5 >> delete: aDocument collection: aMongoCollection [
	| command |

	"https://www.mongodb.com/docs/manual/reference/command/delete"
	command := self
		newQueryCommandWith: [ :spec | spec
			at: 'delete' put: aMongoCollection name;
			at: 'deletes' put: {
				OrderedDictionary new
					at: 'q' put: aDocument;
					at: 'limit' put: 0;
					yourself } ]
		database: aMongoCollection database
		flags: 0.

	^ self executeCommand: command
]

{ #category : 'operations' }
MongoDriverV5 >> executeCommand: command [
	| result |

	"https://www.mongodb.com/docs/manual/reference/command/"
	result := OrderedCollection new.
	command doBlock: [:each | result := each ].

	(self newCommand: command) execute.

	(result notNil and: [ result includesKey: '$err' ])
		ifTrue: [ ^ MongoQueryError signalFor: result ].

	^ result
]

{ #category : 'operations' }
MongoDriverV5 >> insert: aDocument collection: aMongoCollection [
	| command reply |

	"https://www.mongodb.com/docs/manual/reference/command/insert"
	command := self
		newQueryCommandWith: [ :spec | spec
			at: 'insert' put: aMongoCollection name;
			at: 'documents' put: aDocument ]
		database: aMongoCollection database
		flags: 0.

	reply := self executeCommand: command.
	"For insertions, I need to validate I have a good insert reply, it is not enough with
	 a simple 'ok'. So, if is ok (if I arrive here it will be) but 'n' = 0 (meaning there 
	 was no insertion), I need to raise an error."
	((reply at: #n) = 0) ifTrue: [ 
		reply 
			at: #writeErrors 
			ifPresent: [ :errors | MongoCommandInsertError signalFor: errors first ]
			ifAbsent: [ MongoCommandInsertError signalFor: Dictionary new ] ]. 

	^ reply
]

{ #category : 'private - factory' }
MongoDriverV5 >> newCommand: aQuery [

	^ self commandClass
		root: self
		query: aQuery
]

{ #category : 'private - factory' }
MongoDriverV5 >> newCommandQuery: aQuery [

	^ self commandQueryClass
		root: self
		query: aQuery
]

{ #category : 'factory' }
MongoDriverV5 >> newQuery [

	^ super newQuery 
		operation: OpMsgQuery;
		yourself
]

{ #category : 'factory' }
MongoDriverV5 >> newQueryCommand: anOrderedDictionary database: aDatabase flags: flags [

	^ MongoQuery new
		operation: OpMsgCommand;
		database: aDatabase;
		where: anOrderedDictionary;
		flags: flags;
		yourself
]

{ #category : 'operations' }
MongoDriverV5 >> query: aMongoQuery [
	| results |

	"https://www.mongodb.com/docs/manual/reference/command/find"
	results := OrderedCollection new.
	aMongoQuery doBlock ifNil: [
		aMongoQuery doBlock: [:each | results add: each]].

	(self newCommandQuery: aMongoQuery) execute.

	(results isNotEmpty and: [ results first includesKey: '$err' ])
		ifTrue: [ ^ MongoQueryError signalFor: results first ].

	^ results
]

{ #category : 'operations' }
MongoDriverV5 >> queryOne: aMongoQuery [

	aMongoQuery doBlock: [:each |
		^ (each includesKey: '$err')
			ifTrue: [ MongoQueryError signalFor: each ]
			ifFalse: [ each ] ].

	aMongoQuery chunkSize: 1.

	(self newCommandQuery: aMongoQuery) execute.

	^ nil
]

{ #category : 'operations' }
MongoDriverV5 >> update: aDocument with: newDocument collection: aMongoCollection upsert: upsertBoolean multi: multiBoolean [
	| command |

	"https://www.mongodb.com/docs/manual/reference/command/delete"
	command := self
		newQueryCommandWith: [ :spec | spec
			at: 'update' put: aMongoCollection name;
			at: 'updates' put: {
				OrderedDictionary new
					at: 'q' put: aDocument;
					at: 'u' put: newDocument;
					at: 'upsert' put: upsertBoolean;
					at: 'multi' put: multiBoolean;
					yourself } ]
		database: aMongoCollection database
		flags: 0.

	^ self executeCommand: command
]
