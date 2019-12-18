private
ensureMongoIsClosed
	mongo isOpen ifTrue: [
		mongo closeWithTimeout: client connectTimeout ]
