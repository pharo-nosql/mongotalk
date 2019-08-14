accessing
readPreference
	^ readPreference ifNil: [ MongoReadPreference primary ]