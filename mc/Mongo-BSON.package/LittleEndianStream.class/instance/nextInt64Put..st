writing
nextInt64Put: anInteger 
	self nextBytePut: (anInteger bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -8) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -16) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -24) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -32) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -40) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -48) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -56) bitAnd: 16rFF)