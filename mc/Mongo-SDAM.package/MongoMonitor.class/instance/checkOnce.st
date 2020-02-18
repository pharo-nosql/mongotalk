private
checkOnce
	"Perform a single attempt to call ismaster, and handle either success or failure."

	[ self ensureMongoIsOpened.
	self doCheckAndHandleSuccess ]
		on: NetworkError, MongoWireProtocolError
		do: [ :error | 
			self ensureMongoIsClosed.
			self handleConnectionError: error ]