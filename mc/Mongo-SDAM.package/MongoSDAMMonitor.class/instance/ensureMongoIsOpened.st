private
ensureMongoIsOpened
	"Spec: 'Socket timeout for monitoring is connectTimeoutMS'"

	mongo isOpen ifFalse: [
		mongo
			openWithTimeout: client connectTimeout;
			socketTimeout: client connectTimeout ]