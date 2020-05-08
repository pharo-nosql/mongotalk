accessing
maxStaleness: aDuration
	"Replica set members can lag behind the primary due to network congestion, low disk throughput, long-running operations, etc. 
	The read preference maxStalenessSeconds option lets you specify a maximum replication lag, or “staleness”, for reads from secondaries. 
	When a secondary’s estimated staleness exceeds maxStalenessSeconds, the client stops using it for read operations.
	
	See: https://docs.mongodb.com/v4.0/core/read-preference/#replica-set-read-preference-max-staleness
	"

	maxStaleness := aDuration