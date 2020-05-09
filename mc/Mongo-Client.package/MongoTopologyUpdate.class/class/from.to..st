instance creation
from: aMongoServerDescription to: anotherMongoServerDescription
	^ self basicNew
		initializeFrom: aMongoServerDescription
			to: anotherMongoServerDescription;
		yourself