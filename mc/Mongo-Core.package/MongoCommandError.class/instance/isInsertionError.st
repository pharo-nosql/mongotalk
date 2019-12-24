testing
isInsertionError
	^ self codeIfPresent: [ :code | code = 11000 ] ifAbsent: [ false ]