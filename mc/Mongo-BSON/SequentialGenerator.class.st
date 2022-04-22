"
I'm a sequential number generator. 
I'm not very effective, but I can be useful in certain restrained scenarios. 
"
Class {
	#name : #SequentialGenerator,
	#superclass : #UniqueNumberGenerator,
	#instVars : [
		'currentNumber',
		'startNumber'
	],
	#category : 'Mongo-BSON-Generators'
}

{ #category : #defaults }
SequentialGenerator class >> defaultStartNumber [
	^ 0
]

{ #category : #acccessing }
SequentialGenerator >> nextNumber [ 
	currentNumber := currentNumber + 1.
	^ currentNumber.
]

{ #category : #registration }
SequentialGenerator >> register [ 
	currentNumber := self startNumber.
]

{ #category : #acccessing }
SequentialGenerator >> startNumber [ 
	^ startNumber ifNil: [ self class defaultStartNumber ]
]

{ #category : #acccessing }
SequentialGenerator >> startNumber: aNumber [ 
	startNumber := aNumber.
]
