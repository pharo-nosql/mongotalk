Extension { #name : #Boolean }

{ #category : #'*Mongo-BSON' }
Boolean >> bsonTypeCode [
	^8
]

{ #category : #'*Mongo-BSON' }
Boolean >> writeBSONOn: aBSON [ 
	aBSON nextBooleanPut: self
]
