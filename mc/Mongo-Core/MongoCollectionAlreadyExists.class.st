Class {
	#name : #MongoCollectionAlreadyExists,
	#superclass : #Error,
	#instVars : [
		'collectionName'
	],
	#category : 'Mongo-Core-Errors'
}

{ #category : #accessing }
MongoCollectionAlreadyExists >> collectionName [
	^ collectionName
]

{ #category : #accessing }
MongoCollectionAlreadyExists >> collectionName: anObject [
	collectionName := anObject
]
