running
setUp
	super setUp.
	mongo := self newMongo.
	mongo open.