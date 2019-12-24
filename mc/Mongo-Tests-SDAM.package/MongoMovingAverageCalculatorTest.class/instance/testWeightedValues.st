tests
testWeightedValues
	calculator := MongoMovingAverageCalculator new.
	calculator add: 10.
	calculator add: 20.
	self assert: calculator average closeTo: 12.
	calculator add: 30.
	self assert: calculator average closeTo: 15.6.
