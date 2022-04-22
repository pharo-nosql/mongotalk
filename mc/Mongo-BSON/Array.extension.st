Extension { #name : #Array }

{ #category : #'*Mongo-BSON' }
Array >> writeBSONOn: aBSON [ 
	aBSON nextArrayPut: self
]
