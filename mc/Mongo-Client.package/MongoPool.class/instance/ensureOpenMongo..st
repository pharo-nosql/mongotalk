private
ensureOpenMongo: mongo
	mongo isOpen ifTrue: [ ^ self ].
	mongo openWithTimeout: settings connectTimeout.
	mongo socketTimeout: settings socketTimeout.