operations
replSetInitiate: configuration
	"Answer the response of this command, that initializes a new replica set.

	See: https://docs.mongodb.com/v4.0/reference/command/replSetInitiate/"

	^ self command:
		(OrderedDictionary new
			at: 'replSetInitiate' put: configuration;
			yourself)