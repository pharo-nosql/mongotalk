accessing
successfulSecondaryServers
	^ secondaryUrlStrings
		collect: [ :each | self serverAt: each ]
		thenSelect: [ :each | each isSuccess and: [ each isSecondary ] ]