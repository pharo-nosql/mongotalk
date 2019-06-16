private
ensureOpenMongo: mongo
	mongo isOpen ifFalse: [ mongo open ]