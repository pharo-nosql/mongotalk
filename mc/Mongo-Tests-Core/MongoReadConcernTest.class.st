"
A MongoReadConcernTest is a test class for testing the behavior of MongoReadConcern
"
Class {
	#name : #MongoReadConcernTest,
	#superclass : #TestCase,
	#category : #'Mongo-Tests-Core-Utilities'
}

{ #category : #running }
MongoReadConcernTest >> allLevelStrings [
	^ #(local available majority linearizable snapshot)
]

{ #category : #tests }
MongoReadConcernTest >> testAllLevelsAreSingleton [
	self allLevelStrings do: [ :level | 
		| twoAnswers |
		twoAnswers := (1 to: 2)
			collect: [ :each | MongoReadConcern perform: level ].
		self assert: twoAnswers asIdentitySet size equals: 1 ]
]

{ #category : #tests }
MongoReadConcernTest >> testReusesDictionary [
	| aReadConcern twoAnswers |
	aReadConcern := MongoReadConcern local.
	twoAnswers := (1 to: 2)
		collect: [ :each | aReadConcern asConcernForCommand ].
	self assert: twoAnswers asIdentitySet size equals: 1
]
