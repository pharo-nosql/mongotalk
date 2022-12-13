"
An abstract base for mongo drivers. 
My children are the real drivers, see there.
"
Class {
	#name : #MongoDriver,
	#superclass : #Object,
	#classVars : [
		'Default'
	],
	#category : #'Mongo-Core-Base'
}

{ #category : #'instance creation' }
MongoDriver class >> default [

	Default ifNil: [ Default := self obtainDefaultDriver ].
	^ Default new
]

{ #category : #accessing }
MongoDriver class >> default: aClass [ 
	
	Default := aClass
]

{ #category : #testing }
MongoDriver class >> isDefault [
	
	^ false
]

{ #category : #private }
MongoDriver class >> obtainDefaultDriver [

	^ self allSubclasses 
		detect: [ :each | each isDefault ]
		ifNone: [ 
			"just pick one"
			self allSubclasses first ]
]

{ #category : #factory }
MongoDriver >> newCommand: anOrderedDictionary database: aDatabase flags: flags [

	self subclassResponsibility
]

{ #category : #factory }
MongoDriver >> newQuery [

	^ MongoQuery new
]
