Extension { #name : #Association }

{ #category : #'*Mongo-BSON' }
Association >> writeBSONOn: aBSON [ 
	aBSON nextAssociationPut: self
]
