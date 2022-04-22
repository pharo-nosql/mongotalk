"
I represent a mongodb's ""primary"" ReadPreference.

See: https://docs.mongodb.com/v4.0/reference/read-preference/#primary
"
Class {
	#name : #MongoPrimaryReadPreference,
	#superclass : #MongoReadPreference,
	#category : 'Mongo-Client-ReadPreferences'
}

{ #category : #visiting }
MongoPrimaryReadPreference >> accept: aVisitor [
	^ aVisitor visitPrimaryReadPreference: self
]
