initialization
basicServerAt: urlString put: aMongoSDAMServerDescription
	"Mutate this instance with aMongoSDAMServerDescription. Only use during initialization since the topology should be immutable."

	^ serversByUrlString at: urlString put: aMongoSDAMServerDescription