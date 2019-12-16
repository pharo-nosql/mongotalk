accessing
ensureCloseMongo: aMongo
	aMongo isOpen ifTrue: [ aMongo closeWithTimeout: self connectTimeout ]