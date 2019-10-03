private
ensureMongoIsClosed
	mongo isNotNil ifTrue: [ mongo closeIfOpen ]