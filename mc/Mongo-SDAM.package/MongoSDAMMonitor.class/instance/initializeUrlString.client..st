initialization
initializeUrlString: aUrlString client: aMongoSDAMClient
	self initialize.
	urlString := aUrlString.
	client := aMongoSDAMClient.
	mongo := Mongo url: urlString asMongoUrl.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.