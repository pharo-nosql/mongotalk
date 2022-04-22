"
I represent a mongodb's ReadPreference.

See: https://docs.mongodb.com/v4.0/reference/read-preference/
"
Class {
	#name : #MongoReadPreference,
	#superclass : #Object,
	#category : 'Mongo-Client-ReadPreferences'
}

{ #category : #'instance creation' }
MongoReadPreference class >> newNearest [
	^ MongoNearestReadPreference new
]

{ #category : #'instance creation' }
MongoReadPreference class >> newPrimary [
	^ MongoPrimaryReadPreference new
]

{ #category : #'instance creation' }
MongoReadPreference class >> newPrimaryPreferred [
	^ MongoPrimaryPreferredReadPreference new
]

{ #category : #visiting }
MongoReadPreference >> accept: aVisitor [
	^ self subclassResponsibility
]
