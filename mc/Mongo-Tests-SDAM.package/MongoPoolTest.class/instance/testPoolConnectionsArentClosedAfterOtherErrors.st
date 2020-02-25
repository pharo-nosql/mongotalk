tests
testPoolConnectionsArentClosedAfterOtherErrors
	| usedMongoConnections |
	pool maxConnections: 5.

	usedMongoConnections := SharedQueue new.
	pool maxConnections timesRepeat: [ [
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
			1/0 ]] raise: ZeroDivide.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool maxConnections.
	
	"The pool kept all connections open in cache."
	self assert: (usedMongoConnections contents allSatisfy: [:each | each isOpen ]).
