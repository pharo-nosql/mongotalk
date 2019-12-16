private
return: mongo
	connections size >= self maxConnections
		ifTrue: [ self ensureCloseMongo: mongo ]
		ifFalse: [ mutex critical: [ connections add: mongo ] ]