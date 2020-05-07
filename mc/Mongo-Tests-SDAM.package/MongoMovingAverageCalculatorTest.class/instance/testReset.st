tests
testReset
	calculator := MongoMovingAverageCalculator new.
	calculator add: 10.
	calculator add: 20.
	calculator add: 30.
	calculator reset.
	self assert: calculator average == Float nan.
