Extension { #name : #Date }

{ #category : #'*Mongo-BSON' }
Date >> bsonTypeCode [ 
	^9
]

{ #category : #'*Mongo-BSON' }
Date >> duration [ 
	^Duration seconds: self asSeconds  nanoSeconds: 0
]

{ #category : #'*Mongo-BSON' }
Date >> writeBSONOn: aBSON [ 
	aBSON nextDatePut: self
]
