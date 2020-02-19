private
next
	"Answer an instance of Mongo that is open (and then ready to be used).
	
	IMPORTANT: When caller is done with the Mongo instance, it must either release it to this pool (see #return:) or close it (since it references an open Socket... else the Pharo image can run out of external semaphores).

	Wait up to acquireConnectionTimeout if we would exceed the max number of acquired connections.
	Signal MongoAcquireConnectionTimeout if such wait was too long."

	acquireConnectionTimeout ifNotNil: [ 
		| timedout |
		timedout := connectionsSemaphore wait: acquireConnectionTimeout.
		timedout ifTrue: [ MongoAcquireConnectionTimeout signal ] ].

	^ self basicNext