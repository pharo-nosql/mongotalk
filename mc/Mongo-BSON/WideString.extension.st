Extension { #name : #WideString }

{ #category : #'*Mongo-BSON' }
WideString >> writeBSONOn: aBSON [
	aBSON nextWideStringPut: self
]
