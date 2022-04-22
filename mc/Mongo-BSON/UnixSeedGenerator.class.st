"
I use UUIDGenerator>>#makeSeed to provide an unique number. 
I can provide unique numbers in unix platforms, but I'm slow (and of course, I do not work correctly in windows).
"
Class {
	#name : #UnixSeedGenerator,
	#superclass : #UniqueNumberGenerator,
	#category : 'Mongo-BSON-Generators'
}

{ #category : #acccessing }
UnixSeedGenerator >> nextNumber [ 
	^ UUIDGenerator default makeSeed
]
