as yet unclassified
isInsertionError
	"Check for any kind of insertion failure. E.g. duplicate key or other
	errors in the future."
	
	^ self codeIfPresent: [ :code | code = 11000 ] ifAbsent: [ false ]