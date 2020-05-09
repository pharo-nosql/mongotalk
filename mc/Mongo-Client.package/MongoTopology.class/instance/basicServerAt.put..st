initialization
basicServerAt: urlString put: aMongoServerDescription
	"Mutate this instance with aMongoServerDescription. Only use during initialization since the topology should be immutable."

	^ serversByUrlString at: urlString put: aMongoServerDescription