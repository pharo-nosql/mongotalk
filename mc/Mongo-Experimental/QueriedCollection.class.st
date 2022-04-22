Class {
	#name : #QueriedCollection,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'collection'
	],
	#category : 'Mongo-Experimental'
}

{ #category : #'instance creation' }
QueriedCollection class >> collection: aMongoCollection pattern: aDictionary [ 
	^self new setCollection: aMongoCollection pattern: aDictionary
]

{ #category : #enumeration }
QueriedCollection >> do: aBlock [
	collection
		query: pattern 
		do: aBlock
]

{ #category : #testing }
QueriedCollection >> includes: aDictionary [ 
	"Can't think of how to implement this just now"
	self shouldBeImplemented 
]

{ #category : #private }
QueriedCollection >> setCollection: aMongoCollection pattern: aDictionary [ 
	collection := aMongoCollection.
	pattern := aDictionary
]

{ #category : #accessing }
QueriedCollection >> size [
	^collection sizeForQuery: pattern
]
