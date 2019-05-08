initialization
initialize
	super initialize.
	
	type := MongoSDAMTopologyType unknown.
	servers := OrderedCollection new.