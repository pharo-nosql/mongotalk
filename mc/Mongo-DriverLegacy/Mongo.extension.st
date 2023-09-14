Extension { #name : #Mongo }

{ #category : #'*Mongo-DriverLegacy' }
Mongo >> useLegacyDriver [

	self useDriver: MongoLegacyDriver new
]
