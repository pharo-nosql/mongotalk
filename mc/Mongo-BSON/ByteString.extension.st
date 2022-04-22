Extension { #name : #ByteString }

{ #category : #'*Mongo-BSON' }
ByteString >> writeBSONOn: aBSON [ 
	aBSON nextSizedStringPut: self
]
