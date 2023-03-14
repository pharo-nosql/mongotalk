"
An abstract base for mongo drivers. 
My children are the real drivers, see there.
"
Class {
	#name : #MongoDriver,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#classVars : [
		'Default'
	],
	#category : #'Mongo-Core-Base'
}

{ #category : #accessing }
MongoDriver class >> defaultDriver [

	^ Default ifNil: [ Default := self obtainDefaultDriver ]
]

{ #category : #accessing }
MongoDriver class >> defaultDriver: aClass [

	Default := aClass
]

{ #category : #testing }
MongoDriver class >> isDefault [
	
	^ false
]

{ #category : #'instance creation' }
MongoDriver class >> newDefault [

	^ self defaultDriver new
]

{ #category : #private }
MongoDriver class >> obtainDefaultDriver [

	^ self allSubclasses 
		detect: [ :each | each isDefault ]
		ifNone: [ 
			"just pick one"
			self allSubclasses first ]
]

{ #category : #accessing }
MongoDriver >> commandClass [

	^ self subclassResponsibility
]

{ #category : #operations }
MongoDriver >> commandDelete: aDocument limit: aLimit collection: aMongoCollection writeConcern: aConcern [
	"Delete using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/delete/"
	| commandSpec command |

	commandSpec := OrderedDictionary new
		at: 'delete' put: aMongoCollection name;
		at: 'deletes' put: {
			OrderedDictionary new
				at: 'q' put: aDocument;
				at: 'limit' put: aLimit;
				yourself
			};
		yourself.

	aConcern ifNotNil: [
		commandSpec at: 'writeConcern' put: aConcern asConcernForCommand].

	command := self
		newQueryCommand: commandSpec
		database: aMongoCollection database
		flags: 0.

	^ self executeCommandAndVerify: command
]

{ #category : #operations }
MongoDriver >> commandFind: filterDictionary limit: aLimit collection: aMongoCollection readConcern: aMongoReadConcern [
	"Answer a MongoCommandCursor that will perform a find using Mongo command.

	All parameters are optional (nil), except collectionName.

	See more on https://docs.mongodb.com/v4.0/reference/command/find/"
	| commandSpec |

	commandSpec := OrderedDictionary new.
	commandSpec at: 'find' put: aMongoCollection name.
	filterDictionary ifNotNil: [
		commandSpec at: 'filter' put: filterDictionary ].
	aLimit ifNotNil: [
		commandSpec at: 'limit' put: aLimit ].
	aMongoReadConcern ifNotNil: [
		commandSpec at: 'readConcern' put: aMongoReadConcern asConcernForCommand ].

	^ MongoCommandCursor
		database: aMongoCollection database
		dictionary: commandSpec
]

{ #category : #operations }
MongoDriver >> commandInsert: aDocument collection: aMongoCollection writeConcern: aConcern [
	"Insert using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/insert/"
	| command commandSpec |

	commandSpec := OrderedDictionary new
		at: 'insert' put: aMongoCollection name;
		at: 'documents' put: { aDocument };
		yourself.

	aConcern ifNotNil: [
		commandSpec at: 'writeConcern' put: aConcern asConcernForCommand ].

	command := self
		newQueryCommand: commandSpec
		database: aMongoCollection database
		flags: 0.

	^ self executeCommandAndVerify: command
]

{ #category : #accessing }
MongoDriver >> commandQueryClass [

	^ self subclassResponsibility
]

{ #category : #operations }
MongoDriver >> commandUpdate: aDocument with: newDocument collection: aMongoCollection writeConcern: aConcern [
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"
	| commandSpec command |

	commandSpec := OrderedDictionary new
		at: 'update' put: aMongoCollection name;
		at: 'updates' put: { OrderedDictionary new
			at: 'q' put: aDocument;
			at: 'u'put: newDocument;
			yourself };
		yourself.

	aConcern ifNotNil: [
		commandSpec at: 'writeConcern' put: aConcern asConcernForCommand ].

	command := self
		newQueryCommand: commandSpec
		database: aMongoCollection database
		flags: 0.

	^ self executeCommandAndVerify: command
]

{ #category : #operations }
MongoDriver >> cursorQuery: aQuery [
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

{ #category : #operations }
MongoDriver >> delete: aDocument collection: aMongoCollection [

	self subclassResponsibility
]

{ #category : #operations }
MongoDriver >> executeCommand: command [
	^ self subclassResponsibility
]

{ #category : #'private - operations' }
MongoDriver >> executeCommandAndVerify: aCommand [
	| result |

	result := self executeCommand: aCommand.
	result at: 'writeConcernError' ifPresent: [:err |
		MongoCommandError signalFor: err].
	result at: 'writeErrors' ifPresent: [:errors |
		MongoCommandError signalFor: errors last].

	^ result
]

{ #category : #operations }
MongoDriver >> insert: aDocument collection: aMongoCollection [

	self subclassResponsibility
]

{ #category : #factory }
MongoDriver >> newQuery [

	^ MongoQuery new
]

{ #category : #factory }
MongoDriver >> newQueryCommand: anOrderedDictionary database: aDatabase flags: flags [

	self subclassResponsibility
]

{ #category : #factory }
MongoDriver >> newQueryCommandWith: aBlock database: aDatabase flags: flags [
	| spec |

	spec := OrderedDictionary new.
	aBlock value: spec.

	^ self
		newQueryCommand: spec
		database: aDatabase
		flags: flags
]

{ #category : #private }
MongoDriver >> nextRequestID [

	^ self root nextRequestID
]

{ #category : #operations }
MongoDriver >> query: aMongoQuery [
	^ self subclassResponsibility
]

{ #category : #accessing }
MongoDriver >> root [

	^ root
]

{ #category : #accessing }
MongoDriver >> root: aMongo [

	root := aMongo
]

{ #category : #private }
MongoDriver >> stream [

	^ self root stream
]

{ #category : #operations }
MongoDriver >> update: aDocument with: newDocument collection: aMongoCollection upsert: upsertBoolean multi: multiBoolean [

	self subclassResponsibility
]
