Extension { #name : #DateAndTime }

{ #category : #'*Mongo-Squeak' }
DateAndTime >> bsonTypeCode [
	^9
]

{ #category : #'*Mongo-Squeak' }
DateAndTime >> writeBSONOn: aBSON [ 
	aBSON nextDateAndTimePut: self
]
