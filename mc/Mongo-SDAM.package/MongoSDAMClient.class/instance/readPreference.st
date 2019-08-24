accessing
readPreference
	^ readPreference ifNil: [ MongoReadPreference newPrimary ]