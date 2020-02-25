tests
testNormallyCacheMaxConnections
	| usedMongoConnections |
	pool maxConnections: 5.

	usedMongoConnections := SharedQueue new.
	pool maxConnections + 1 timesRepeat: [ [
		pool mongoDo: [ :mongo |
			usedMongoConnections nextPut: mongo.
			self smallLapse wait ] ] fork ].

	"Ensure each forked process obtain a connection."
	(self smallLapse * 2)	 wait.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool maxConnections + 1.
	
	"The pool keeps #maxConnection open connections and
	closes the exceeding one when returned."
	self
		assert: (usedMongoConnections contents count: [:each | each isOpen ])
		equals: pool maxConnections.
