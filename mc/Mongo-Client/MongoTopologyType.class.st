"
I represent the type of topology of a MongoClient.

For the moment, I only have class-side methods that answer Symbols.
"
Class {
	#name : #MongoTopologyType,
	#superclass : #Object,
	#category : 'Mongo-Client-Topology'
}

{ #category : #'instance creation' }
MongoTopologyType class >> replicaSetNoPrimary [
	^ #replicaSetNoPrimary
]

{ #category : #'instance creation' }
MongoTopologyType class >> replicaSetWithPrimary [
	^ #replicaSetWithPrimary
]

{ #category : #'instance creation' }
MongoTopologyType class >> single [
	^ #single
]

{ #category : #'instance creation' }
MongoTopologyType class >> unknown [
	^ #unknown
]
