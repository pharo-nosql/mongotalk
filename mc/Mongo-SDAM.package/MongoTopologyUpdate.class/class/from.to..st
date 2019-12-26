instance creation
from: aMongoSDAMServerDescription to: anotherMongoSDAMServerDescription
	^ self basicNew
		initializeFrom: aMongoSDAMServerDescription
			to: anotherMongoSDAMServerDescription;
		yourself