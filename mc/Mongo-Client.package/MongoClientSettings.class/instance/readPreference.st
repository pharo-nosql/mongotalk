accessing - server selection
readPreference
	^ readPreference ifNil: [
		readPreference := MongoReadPreference newPrimary ]