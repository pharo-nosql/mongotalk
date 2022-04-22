"
Helper for validation of collections

Instance Variables
	values:		<Object>

values
	- xxxxx

"
Class {
	#name : #CollectionValidation,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : 'Mongo-Core-Utilities'
}

{ #category : #'instance creation' }
CollectionValidation class >> on: aDictionary [ 
	^self new setValues: aDictionary
]

{ #category : #testing }
CollectionValidation >> isOK [
	^(values at: 'ok') = 1.0
]

{ #category : #private }
CollectionValidation >> setValues: aDictionary [ 
	values := aDictionary
]
