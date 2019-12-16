*Mongo-Core
close: timeoutAsNumberOfSeconds
	"Flush any data still not sent and take care of the socket."

	self flush.
	socket closeAndDestroy: timeoutAsNumberOfSeconds