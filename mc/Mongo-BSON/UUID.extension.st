Extension { #name : #UUID }

{ #category : #'*mongo-bson' }
UUID >> bsonTypeCode [ 
	^ 5
]

{ #category : #'*mongo-bson' }
UUID >> writeBSONOn: aBSON [
	aBSON nextUUIDPut: self
]
