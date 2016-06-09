tests
testAddExistingCollection

	self 
		should: [ database addCollection: 'testCollection' ]
		raise: MongoCollectionAlreadyExists.
