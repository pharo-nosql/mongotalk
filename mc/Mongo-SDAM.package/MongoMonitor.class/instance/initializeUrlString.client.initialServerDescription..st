initialization
initializeUrlString: aUrlString client: aMongoSDAMClient initialServerDescription: aMongoSDAMServerDescription
	self initialize.

	urlString := aUrlString.
	client := aMongoSDAMClient.
	latestServerDescription := aMongoSDAMServerDescription.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.

	pool := MongoPool
		url: urlString asMongoUrl
		settings: client settings.

	"Spec: 'Servers are monitored with dedicated sockets'"
	mongo := Mongo url: urlString asMongoUrl.
