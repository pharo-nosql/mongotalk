initialization
initializeUrlString: aUrlString client: aMongoSDAMClient
	self initialize.
	urlString := aUrlString.
	client := aMongoSDAMClient.
	checkMongo := Mongo url: urlString asMongoUrl.
	pool := MongoPool url: urlString asMongoUrl.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.