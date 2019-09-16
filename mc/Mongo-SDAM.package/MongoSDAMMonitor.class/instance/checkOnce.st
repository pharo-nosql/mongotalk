accessing
checkOnce
	"A single attempt to call ismaster. Answer a new server description."

	| isMasterResponse roundtripDuration |
	[ 	[
		checkMongo openWithTimeout: client connectTimeout.
		roundtripDuration := [ isMasterResponse := checkMongo isMaster ] timeToRun ]
				on: ConnectionTimedOut
				do: [ :error |
					roundtripTimeCalculator reset. 
					^ MongoSDAMUnreachableServerDescription urlString: urlString ]
		] ensure: [ self ensureMongoClosed ].

	roundtripTimeCalculator add: roundtripDuration asMilliSeconds.

	^ MongoSDAMServerDescription
		isMaster: isMasterResponse
		roundtripTime: self roundtripDurationAverage