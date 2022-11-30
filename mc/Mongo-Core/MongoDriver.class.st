"
An abstract base for mongo drivers. 
My children are the real drivers, see there.
"
Class {
	#name : #MongoDriver,
	#superclass : #Object,
	#category : #'Mongo-Core-Base'
}

{ #category : #'instance creation' }
MongoDriver class >> default [

	^ (self allSubclasses 
		detect: [ :each | each isDefault ]
		ifNone: [ 
			"just pick one"
			self allSubclasses first ])
		new
]

{ #category : #testing }
MongoDriver class >> isDefault [
	
	^ false
]

{ #category : #factory }
MongoDriver >> newCommand: anOrderedDictionary database: aDatabase flags: flags [

	self subclassResponsibility
]

{ #category : #factory }
MongoDriver >> newQuery [

	^ MongoQuery new
]
