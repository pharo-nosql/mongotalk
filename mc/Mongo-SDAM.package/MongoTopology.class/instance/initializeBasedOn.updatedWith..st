initialization
initializeBasedOn: anotherMongoSDAMTopology updatedWith: aMongoSDAMServerDescription

	"Never loose some information from past topologies."
	serversByUrlString := anotherMongoSDAMTopology serversByUrlString deepCopy.
	serversByUrlString
		at: aMongoSDAMServerDescription urlString
		put: aMongoSDAMServerDescription.

	aMongoSDAMServerDescription isSuccess
		ifTrue: [ self updateWithIsMasterResponseFrom: aMongoSDAMServerDescription ]
		ifFalse: [ self overcomeErrorBasedOn: anotherMongoSDAMTopology updatedWith: aMongoSDAMServerDescription ]
