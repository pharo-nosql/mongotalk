Extension { #name : #String }

{ #category : #'*Mongo-BSON' }
String >> asBSONRegex [
	^BSONRegex value: self
]

{ #category : #'*Mongo-BSON' }
String >> bsonTypeCode [
	^2
]
