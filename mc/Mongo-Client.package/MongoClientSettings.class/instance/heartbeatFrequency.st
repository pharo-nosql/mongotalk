accessing - monitor
heartbeatFrequency
	"See: https://docs.mongodb.com/manual/reference/connection-string/#urioption.heartbeatFrequencyMS"

	^ heartbeatFrequency ifNil: [ 
		heartbeatFrequency := 10 seconds ]