accessing
readPreference
	^ readPreference ifNil: [
		readPreference := MongoReadPreference newPrimary ]