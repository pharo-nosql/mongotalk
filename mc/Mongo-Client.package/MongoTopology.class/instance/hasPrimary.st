testing
hasPrimary
	^ primaryUrlString notNil and: [ (self serverAt: primaryUrlString) isSuccess ]