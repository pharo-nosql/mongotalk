Class {
	#name : #MongoWholeDatabaseTest,
	#superclass : #MongoTest,
	#category : 'Mongo-Tests-Core-Tests'
}

{ #category : #running }
MongoWholeDatabaseTest >> setUp [
	root := Mongo default.
	root open.
	database := root databaseNamed: 'testWholeDatabase'.
	collection := database addCollection: 'testCollection'
]

{ #category : #running }
MongoWholeDatabaseTest >> tearDown [
	database ifNotNil: [ database drop ].
	root closeIfOpen
]

{ #category : #tests }
MongoWholeDatabaseTest >> testBasics [
	self assert: collection validate isOK
]
