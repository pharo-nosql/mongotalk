Extension { #name : #UndefinedObject }

{ #category : #'*Mongo-BSON' }
UndefinedObject >> bsonTypeCode [
	^10
]

{ #category : #'*Mongo-BSON' }
UndefinedObject >> writeBSONOn: aBSON [ 
	aBSON nextNilPut
]
