"
I represent a mongodb's ""nearest"" ReadPreference.

See: https://docs.mongodb.com/v4.0/reference/read-preference/#nearest
"
Class {
	#name : #MongoNearestReadPreference,
	#superclass : #MongoNonPrimaryReadPreference,
	#category : 'Mongo-Client-ReadPreferences'
}

{ #category : #visiting }
MongoNearestReadPreference >> accept: aVisitor [
	^ aVisitor visitNearestReadPreference: self
]
