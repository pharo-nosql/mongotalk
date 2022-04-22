Extension { #name : #ByteSymbol }

{ #category : #'*Mongo-BSON' }
ByteSymbol >> writeBSONOn: aBSON [ 
	self deprecated: 'The usage of symbols is deprecated in BSON. This value will be written as String to the database and you will return a String from the database'.
	aBSON nextSizedStringPut: self
]
