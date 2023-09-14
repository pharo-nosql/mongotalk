Extension { #name : #Integer }

{ #category : #'*Mongo-BSON' }
Integer >> asBSONDate [

	^ self asBSONDateAndTime asDate - 1 day
]

{ #category : #'*Mongo-BSON' }
Integer >> asBSONDateAndTime [

	^ DateAndTime unixEpoch  + (Duration milliSeconds: self)
]

{ #category : #'*Mongo-BSON' }
Integer >> bsonTypeCode [
	(BSON new isInt32: self) ifTrue: [^16].
	(BSON new isInt64: self) ifTrue: [^18].
	self error: 'Integer too large: ' , self printString
]

{ #category : #'*Mongo-BSON' }
Integer >> writeBSONOn: aBSON [
	aBSON nextIntegerPut: self
]
