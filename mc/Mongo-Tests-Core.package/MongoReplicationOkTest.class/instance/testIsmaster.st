tests
testIsmaster

	| response |
	response := mongo ismaster.
	
	self deny: response isNil.