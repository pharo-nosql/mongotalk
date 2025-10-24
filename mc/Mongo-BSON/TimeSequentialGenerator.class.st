"
I'm a generator that generates sequential numbers, with a star numbers that is calculated with the clock millisecons number. 
"
Class {
	#name : 'TimeSequentialGenerator',
	#superclass : 'SequentialGenerator',
	#category : 'Mongo-BSON-Generators',
	#package : 'Mongo-BSON',
	#tag : 'Generators'
}

{ #category : 'private' }
TimeSequentialGenerator >> startNumber [ 
	^ Time millisecondClockValue.
]
