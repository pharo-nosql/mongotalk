private
return: mongo
	connections size >= self maxConnections
		ifTrue: [ mongo closeIfOpen ]
		ifFalse: [ mutex critical: [ connections add: mongo ] ]