private
successfulSecondaryMonitors
	^ monitors select: [ :each |
		each latestServerDescription isSuccess and: [
		each latestServerDescription isSecondary ] ]
