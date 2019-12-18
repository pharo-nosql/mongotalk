private
successfulMonitors
	^ monitors select: [ :each |
		each latestServerDescription isSuccess ]