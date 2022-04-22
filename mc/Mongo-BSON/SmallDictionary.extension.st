Extension { #name : #SmallDictionary }

{ #category : #'*Mongo-BSON' }
SmallDictionary >> bsonTypeCode [
	^3
]

{ #category : #'*Mongo-BSON' }
SmallDictionary >> writeBSONOn: aBSON [ 
	aBSON nextOrderedDictionaryPut: self
]
