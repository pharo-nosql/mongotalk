Class {
	#name : #MongoQueryReadPreferencesTest,
	#superclass : #MongoReadPreferencesTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #hooks }
MongoQueryReadPreferencesTest >> doReadOnCollection: collection [
	^ self wireProtocolReadOn: collection
]

{ #category : #hooks }
MongoQueryReadPreferencesTest >> doWriteOnCollection: collection [
	self wireProtocolWriteOn: collection
]
