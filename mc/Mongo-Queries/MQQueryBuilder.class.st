"
Used to build a mongo query

Instance Variables
	label:		<Object>

label
	- xxxxx

"
Class {
	#name : #MQQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'label'
	],
	#category : 'Mongo-Queries-Building'
}

{ #category : #'instance creation' }
MQQueryBuilder class >> queryFor: aBlock [
	^ self new buildQueryFor: aBlock
]

{ #category : #building }
MQQueryBuilder >> buildQueryFor: aBlock [
	^ self newGenerator visit: (aBlock value: self newQuery)
]

{ #category : #factory }
MQQueryBuilder >> newGenerator [
	^ MQMongoQueryGenerator new
]

{ #category : #factory }
MQQueryBuilder >> newQuery [
	^ MQQuery new
]
