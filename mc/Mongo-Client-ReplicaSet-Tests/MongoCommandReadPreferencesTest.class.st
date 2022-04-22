Class {
	#name : #MongoCommandReadPreferencesTest,
	#superclass : #MongoReadPreferencesTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #hooks }
MongoCommandReadPreferencesTest >> doReadOnCollection: collection [
	^ self commandReadOn: collection
]

{ #category : #hooks }
MongoCommandReadPreferencesTest >> doWriteOnCollection: collection [
	self commandWriteOn: collection
]
