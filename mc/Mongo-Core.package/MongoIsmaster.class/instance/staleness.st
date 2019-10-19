accessing
staleness
	"Answer the 'replication lag' of a non primary server.
	
	See: https://docs.mongodb.com/v4.0/core/read-preference/#maxstalenessseconds"

	^ self localTime - self lastWriteDateAndTime