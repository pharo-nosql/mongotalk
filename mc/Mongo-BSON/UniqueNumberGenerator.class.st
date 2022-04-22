"
I'm a base generator of unique numbers. 
Since this is a not easy task, it can be tricky to provide a unique startegy in any platform or that fits to all purpose. 
My children provide different strategies. 
"
Class {
	#name : #UniqueNumberGenerator,
	#superclass : #Object,
	#category : 'Mongo-BSON-Generators'
}

{ #category : #acccessing }
UniqueNumberGenerator >> nextNumber [ 
	^ self subclassResponsibility
]

{ #category : #registration }
UniqueNumberGenerator >> register [ 
	
]

{ #category : #registration }
UniqueNumberGenerator >> unregister [ 
	
]
