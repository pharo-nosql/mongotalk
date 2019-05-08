accessing
serverAt: urlString
	^ servers detect: [ :each | each urlString = urlString ]