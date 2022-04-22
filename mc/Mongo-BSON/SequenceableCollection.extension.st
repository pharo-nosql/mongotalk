Extension { #name : #SequenceableCollection }

{ #category : #'*Mongo-BSON' }
SequenceableCollection >> bsonTypeCode [
	^4
]

{ #category : #'*Mongo-BSON' }
SequenceableCollection >> writeBSONOn: aBSON [ 
	self asArray writeBSONOn: aBSON
]
