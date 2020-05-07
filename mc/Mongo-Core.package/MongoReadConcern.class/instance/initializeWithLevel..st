accessing
initializeWithLevel: aString
	self initialize.
	dictionary := Dictionary new
		at: 'level' put: aString;
		yourself