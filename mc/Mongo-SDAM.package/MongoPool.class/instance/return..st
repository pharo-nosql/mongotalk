private
return: mongo
	"Return to this pool an instance of Mongo. Such instance should be open and ready to be answered by #next on a new operation."

	connections size >= self maxConnections
		ifTrue: [ self ensureCloseMongo: mongo ]
		ifFalse: [ mutex critical: [ connections add: mongo ] ]