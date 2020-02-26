tests
testPoolConnectionsAreClosedAfterNetworkError
	| usedMongoConnections |
	pool settings maxConnections: 5.

	usedMongoConnections := SharedQueue new.
	pool settings maxConnections timesRepeat: [ [
		pool mongoDo: [ :mongo |
			usedMongoConnections nextPut: mongo.
			self smallLapse wait ] ] fork ].

	"Ensure each forked process obtain a connection."
	(self smallLapse * 2)	 wait.

	"Produce a (fake) network error. The pool should react by
	closing all connections but also must pass it for externally hnadling it."
	self should: [
		pool mongoDo: [ :mongo |
			usedMongoConnections nextPut: mongo.
			NetworkError signal ]] raise: NetworkError.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool settings maxConnections.
	
	"The pool closed all connections."
	self assert: (usedMongoConnections contents noneSatisfy: [:each | each isOpen ]).
