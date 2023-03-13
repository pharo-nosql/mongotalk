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

{ #category : #accessing }
MongoDriver >> commandQueryClass [

	^ self subclassResponsibility
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
