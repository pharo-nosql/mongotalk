*Mongo-BSON
bsonTypeCode
	(BSON new isInt32: self) ifTrue: [^16].
	(BSON new isInt64: self) ifTrue: [^18].
	self error: 'Integer too large: ' , self printString