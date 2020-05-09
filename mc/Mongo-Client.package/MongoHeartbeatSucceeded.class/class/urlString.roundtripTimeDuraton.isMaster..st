instance creation
urlString: aUrlString roundtripTimeDuraton: aDuration isMaster: aMongoIsMaster
	^ self basicNew
		initializeWithUrlString: aUrlString
			roundTripTimeDuraton: aDuration
			isMaster: aMongoIsMaster;
		yourself