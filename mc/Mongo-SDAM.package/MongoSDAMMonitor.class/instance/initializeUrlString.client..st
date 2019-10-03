initialization
initializeUrlString: aUrlString client: aMongoSDAMClient
	self initialize.

	urlString := aUrlString.
	client := aMongoSDAMClient.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.

	pool := MongoPool url: urlString asMongoUrl.

	"Spec: 'Servers are monitored with dedicated sockets'"
	mongo := Mongo url: urlString asMongoUrl.
