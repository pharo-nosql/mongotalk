Class {
	#name : #SelectTest,
	#superclass : #MongoTestCase,
	#instVars : [
		'root',
		'database',
		'collection'
	],
	#category : 'Mongo-Experimental'
}

{ #category : #'as yet unclassified' }
SelectTest >> setUp [
	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
]

{ #category : #'as yet unclassified' }
SelectTest >> tearDown [
	collection drop.
	root close
]

{ #category : #'as yet unclassified' }
SelectTest >> testQuery [
	| uno filtered dos count |
	uno := Dictionary new at: 'key' put: 'uno'; yourself.
	collection add: uno.
	dos := Dictionary new at: 'key' put: 'dos'; yourself.
	collection add: dos.
	filtered := collection select: uno.
	self assert: filtered size = 1.
	count := 0.
	filtered do: [:each | self assert: (each at: 'key') = 'uno'. count := count + 1].
	self assert: count = 1.
"	self assert: (filtered includes: uno).
	self deny: (filtered includes: dos)"
]
