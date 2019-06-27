accessing
checkOnce
	"A single attempt to call ismaster. Answer a new server description."

	| ismaster roundtripTime |
	[ 	[
		checkMongo openWithTimeout: client connectTimeout.
		roundtripTime := [ ismaster := checkMongo isMaster ] timeToRun ]
				on: ConnectionTimedOut
				do: [ :error |
					roundtripTimeCalculator reset. 
					^ MongoSDAMUnreachableServerDescription urlString: urlString ]
		] ensure: [ self ensureMongoClosed ].

	roundtripTimeCalculator add: roundtripTime asMilliSeconds.

	^ MongoSDAMServerDescription
		isMaster: ismaster
		roundtripTime: roundtripTimeCalculator average