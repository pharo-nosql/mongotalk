accessing
handleConnectionError: anError
	"React to a connection error to a server. This includes both heatbeat and
	command connections.
	When a server goes down, this methods may be evaluated many times (one
	for each ongoing command + one for a heatbeat), but will consider only first."

	latestServerDescription isError ifTrue: [ ^ self ].
	
	roundtripTimeCalculator reset.

	self latestServerDescription:
		(MongoErrorServerDescription
			urlString: urlString
			errorDescription: anError description)