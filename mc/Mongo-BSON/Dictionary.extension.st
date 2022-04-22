Extension { #name : #Dictionary }

{ #category : #'*Mongo-BSON' }
Dictionary >> bsonTypeCode [
	^3
]

{ #category : #'*Mongo-BSON' }
Dictionary >> writeBSONOn: aBSON [ 
	aBSON nextDictionaryPut: self
]
