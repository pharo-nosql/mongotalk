operations
addCollection: aString
	^ self
		addCollection: aString
		capped: false
		size: nil
		max: nil