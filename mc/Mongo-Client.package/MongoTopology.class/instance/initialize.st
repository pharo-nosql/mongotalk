initialization
initialize
	super initialize.
	
	type := MongoTopologyType unknown.
	serversByUrlString := Dictionary new.
	secondaryUrlStrings := #().
	primaryUrlString := nil.