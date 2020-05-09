tests
testInitiallyNaN
	calculator := MongoMovingAverageCalculator new.
	self assert: calculator average == Float nan.
