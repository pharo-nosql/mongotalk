tests
testAcquireConnectionTimeout
	| completedSemaphore maxConnections acquireConnectionTimeout |
	maxConnections := 5.
	acquireConnectionTimeout := 100 milliSeconds.
	
	pool
		maxConnections: maxConnections;
		acquireConnectionTimeout: acquireConnectionTimeout.
	
	completedSemaphore := Semaphore new.

	maxConnections timesRepeat: [
		[	pool mongoDo: [ :mongo | 
				(acquireConnectionTimeout * 2) wait.
				completedSemaphore signal  ]. 
		] fork ].

	"Ensure all connections are acquired by the forked processes."
	5 milliSeconds wait.

	"There are no more connections available before timeout."	
	self
		should: [ pool mongoDo: [ :mongo | ] ]
		raise: MongoAcquireConnectionTimeout.

	"Wait until the forked processes release the connections."
	maxConnections timesRepeat: [
		completedSemaphore wait: acquireConnectionTimeout*2 ].

	"We can acquire again all available connections."
	maxConnections timesRepeat: [
		[	pool mongoDo: [ :mongo |
			(acquireConnectionTimeout * 2) wait ]. 
		] fork ].
	5 milliSeconds wait.

	"And again, there are no more connections available before timeout."	
	self
		should: [ pool mongoDo: [ :mongo | ] ]
		raise: MongoAcquireConnectionTimeout.
