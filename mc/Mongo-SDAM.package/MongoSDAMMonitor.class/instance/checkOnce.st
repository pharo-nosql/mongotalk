accessing
checkOnce
	"A single attempt to call ismaster. Answer a new server description."

	| ismaster roundtripTime |
	[ 	[
		mongo openWithTimeout: client connectTimeout.
		roundtripTime := [ ismaster := mongo ismaster ] timeToRun ]
				on: ConnectionTimedOut
				do: [ :error |
					roundtripTimeCalculator reset. 
					^ MongoSDAMUnreachableServerDescription urlString: urlString ]
		] ensure: [ self ensureMongoClosed ].

	roundtripTimeCalculator add: roundtripTime asMilliSeconds.

	^ MongoSDAMServerDescription
		ismaster: ismaster
		roundtripTime: roundtripTimeCalculator average