accessing
readPreference
	^ MongoReadPreference newPrimaryPreferred
		maxStaleness: 90 seconds;
		yourself