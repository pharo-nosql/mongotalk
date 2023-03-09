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

{ #category : #'as yet unclassified' }
MongoDriver >> executeCommand: command [ 
	^ self subclassResponsibility
]

{ #category : #operations }
MongoDriver >> insert: aDocument inCollection: aMongoCollection inDatabase: aMongoDatabase [

	self subclassResponsibility
]

{ #category : #factory }
MongoDriver >> newCommand: anOrderedDictionary database: aDatabase flags: flags [

	self subclassResponsibility
]

{ #category : #factory }
MongoDriver >> newQuery [

	^ MongoQuery new
]

{ #category : #'as yet unclassified' }
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
