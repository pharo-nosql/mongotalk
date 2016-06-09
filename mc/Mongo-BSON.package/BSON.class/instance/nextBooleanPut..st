writing
nextBooleanPut: aBoolean
	stream nextBytePut: (aBoolean ifTrue: [1] ifFalse: [0])