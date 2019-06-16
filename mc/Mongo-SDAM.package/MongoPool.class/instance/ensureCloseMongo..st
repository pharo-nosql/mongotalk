private
ensureCloseMongo: mongo
	mongo isOpen ifTrue: [ mongo close ]