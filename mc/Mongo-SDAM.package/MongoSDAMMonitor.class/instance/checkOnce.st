accessing
checkOnce
	"A single attempt to call ismaster. Answer a new server description."

	| isMasterResponse roundtripTime |
	[ 	[
		checkMongo openWithTimeout: client connectTimeout.
		roundtripTime := [ isMasterResponse := checkMongo isMaster ] timeToRun ]
				on: ConnectionTimedOut
				do: [ :error |
					roundtripTimeCalculator reset. 
					^ MongoSDAMUnreachableServerDescription urlString: urlString ]
		] ensure: [ self ensureMongoClosed ].

	roundtripTimeCalculator add: roundtripTime asMilliSeconds.

	^ MongoSDAMServerDescription
		isMaster: isMasterResponse
		roundtripTime: roundtripTimeCalculator average