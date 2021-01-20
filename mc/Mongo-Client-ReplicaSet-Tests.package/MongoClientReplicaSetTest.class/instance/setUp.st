running
setUp
	super setUp.

	Transcript << self asString; << ' setUp '.
	MongoReplicationTestResources waitTestingScenario.