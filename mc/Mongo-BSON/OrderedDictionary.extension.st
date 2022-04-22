Extension { #name : #OrderedDictionary }

{ #category : #'*Mongo-BSON' }
OrderedDictionary >> bsonTypeCode [
	^3
]

{ #category : #'*Mongo-BSON' }
OrderedDictionary >> writeBSONOn: aBSON [ 
	aBSON nextOrderedDictionaryPut: self
]
