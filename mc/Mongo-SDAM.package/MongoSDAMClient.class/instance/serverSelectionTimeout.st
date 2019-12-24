accessing
serverSelectionTimeout
	"See: https://docs.mongodb.com/manual/reference/connection-string/#urioption.serverSelectionTimeoutMS"

	^ serverSelectionTimeout ifNil: [ 
		serverSelectionTimeout := 30 seconds ]