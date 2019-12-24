accessing
serverAtUrl: aZnUrl
	^ servers detect: [ :each | each url = aZnUrl ]