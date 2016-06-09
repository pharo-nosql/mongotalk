writing
nextInt32Put: anInteger 
	self nextBytePut: (anInteger bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -8) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -16) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -24) bitAnd: 16rFF)