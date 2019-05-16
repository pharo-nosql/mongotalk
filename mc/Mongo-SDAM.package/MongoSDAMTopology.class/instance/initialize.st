initialization
initialize
	super initialize.
	
	type := MongoSDAMTopologyType unknown.
	serversByUrlString := Dictionary new.