private
ensureOpenMongo: mongo
	mongo isOpen ifFalse: [
		mongo openWithTimeout: self connectTimeout.
		mongo socketTimeout: self socketTimeout ]