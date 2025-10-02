Class {
	#name : 'MongoCollectionAlreadyExists',
	#superclass : 'Error',
	#instVars : [
		'collectionName'
	],
	#category : 'Mongo-Core-Errors',
	#package : 'Mongo-Core',
	#tag : 'Errors'
}

{ #category : 'accessing' }
MongoCollectionAlreadyExists >> collectionName [
	^ collectionName
]

{ #category : 'accessing' }
MongoCollectionAlreadyExists >> collectionName: anObject [
	collectionName := anObject
]
