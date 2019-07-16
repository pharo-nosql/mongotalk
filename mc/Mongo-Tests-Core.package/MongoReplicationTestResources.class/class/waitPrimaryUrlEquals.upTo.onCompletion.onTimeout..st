as yet unclassified
waitPrimaryUrlEquals: aZnUrl upTo: aDuration onCompletion: successBlock onTimeout: failBlock
	| expectedUrlString |
	expectedUrlString := aZnUrl asMongoUrlString.
	^ self
		waitMongoAt: aZnUrl
		satisfies: [ :mongo | 
			| isMasterResponse |
			isMasterResponse := mongo isMaster.
			isMasterResponse hasPrimary
				and: [ isMasterResponse primaryUrlString = expectedUrlString ] ]
		upTo: aDuration
		onCompletion: successBlock
		onTimeout: failBlock