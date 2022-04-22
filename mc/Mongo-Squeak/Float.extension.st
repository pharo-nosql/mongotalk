Extension { #name : #Float }

{ #category : #'*Mongo-Squeak' }
Float >> writeBSONOn: aBSON [ 
	aBSON nextDoublePut: self
]
