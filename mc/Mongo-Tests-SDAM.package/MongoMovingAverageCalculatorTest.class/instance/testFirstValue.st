tests
testFirstValue
	calculator := MongoMovingAverageCalculator new.
	calculator add: 10.
	self assert: calculator average equals: 10.