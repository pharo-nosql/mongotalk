tests
testPoolConnectionsArentClosedAfterOtherErrors
	| usedMongoConnections |
	pool maxConnections: 5.

	usedMongoConnections := SharedQueue new.

	"Produce an error on each forked process. 
	The pool should do nothing on cached Mongo connections but
	pass the error for external handlers."
	pool maxConnections timesRepeat: [ [
		self
			should: [
				pool mongoDo: [ :mongo |
					usedMongoConnections nextPut: mongo.
					self smallLapse wait.
					1/0 ] ]
			raise: ZeroDivide ] fork ].

	"Wait enough for each forked process to terminate."
	(self smallLapse * 2)	 wait.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool maxConnections.
	
	"The pool kept all connections open in cache."
	self assert: (usedMongoConnections contents allSatisfy: [ :each | each isOpen ]).
