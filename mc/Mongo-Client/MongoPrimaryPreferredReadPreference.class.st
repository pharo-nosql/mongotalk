"
I represent a mongodb's ""primaryPreferred"" ReadPreference.

See: https://docs.mongodb.com/v4.0/reference/read-preference/#primaryPreferred
"
Class {
	#name : 'MongoPrimaryPreferredReadPreference',
	#superclass : 'MongoNonPrimaryReadPreference',
	#category : 'Mongo-Client-ReadPreferences',
	#package : 'Mongo-Client',
	#tag : 'ReadPreferences'
}

{ #category : 'visiting' }
MongoPrimaryPreferredReadPreference >> accept: aVisitor [
	^ aVisitor visitPrimaryPreferedReadPreference: self
]
