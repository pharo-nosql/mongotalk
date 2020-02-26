private
return: mongo
	"Release to this pool an instance of Mongo previously obtained via #next. Ideally, such Mongo instance should be open and ready to be answered by #next on a new operation."

	mutex critical: [
		connections size >= settings maxConnections
			ifTrue: [ self ensureCloseMongo: mongo ]
			ifFalse: [ connections add: mongo ] ]