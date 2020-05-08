initialization
initializeUrlString: aUrlString client: aMongoClient initialServerDescription: aMongoServerDescription
	self initialize.

	urlString := aUrlString.
	client := aMongoClient.
	latestServerDescription := aMongoServerDescription.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.

	pool := MongoPool
		url: urlString asMongoUrl
		settings: client settings.

	"Spec: 'Servers are monitored with dedicated sockets'"
	mongo := Mongo url: urlString asMongoUrl.
