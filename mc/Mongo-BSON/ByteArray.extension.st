Extension { #name : #ByteArray }

{ #category : #'*Mongo-BSON' }
ByteArray >> bsonTypeCode [
	^5
]

{ #category : #'*Mongo-BSON' }
ByteArray >> writeBSONOn: aBSON [ 
	aBSON nextByteArrayPut: self
]
