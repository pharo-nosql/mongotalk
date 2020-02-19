private
ensureOpenMongo: mongo
	mongo isOpen ifTrue: [ ^ self ].
	mongo openWithTimeout: self connectTimeout.
	mongo socketTimeout: self socketTimeout.