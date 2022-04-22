"
Tracks an exponentially-weighted moving average.
"
Class {
	#name : #MongoMovingAverageCalculator,
	#superclass : #Object,
	#instVars : [
		'previous'
	],
	#category : 'Mongo-Client-Utilities'
}

{ #category : #evaluating }
MongoMovingAverageCalculator >> add: aNumber [
	previous := previous
		ifNil: [ aNumber ]
		ifNotNil: [ (0.8 * previous) + (0.2 * aNumber) ]
]

{ #category : #evaluating }
MongoMovingAverageCalculator >> average [
	^ previous ifNil: [ Float nan ] ifNotNil: [ previous ]
]

{ #category : #accessing }
MongoMovingAverageCalculator >> reset [
	previous := nil.
]
