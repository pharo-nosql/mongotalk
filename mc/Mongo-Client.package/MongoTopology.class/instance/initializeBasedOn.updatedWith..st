initialization
initializeBasedOn: anotherMongoTopology updatedWith: aMongoServerDescription

	"Never loose some information from past topologies."
	serversByUrlString := anotherMongoTopology serversByUrlString deepCopy.
	serversByUrlString
		at: aMongoServerDescription urlString
		put: aMongoServerDescription.

	aMongoServerDescription isSuccess
		ifTrue: [ self updateWithIsMasterResponseFrom: aMongoServerDescription ]
		ifFalse: [ self overcomeErrorBasedOn: anotherMongoTopology updatedWith: aMongoServerDescription ]
