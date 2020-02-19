initialization
initializeUrlString: aUrlString client: aMongoSDAMClient initialServerDescription: aMongoSDAMServerDescription
	self initialize.

	urlString := aUrlString.
	client := aMongoSDAMClient.
	latestServerDescription := aMongoSDAMServerDescription.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.

	pool := MongoPool
		url: urlString asMongoUrl
		maxConnections: client maxConnections
		connectTimeout: client connectTimeout
		socketTimeout: client socketTimeout
		acquireConnectionTimeout: client acquireConnectionTimeout.

	"Spec: 'Servers are monitored with dedicated sockets'"
	mongo := Mongo url: urlString asMongoUrl.
