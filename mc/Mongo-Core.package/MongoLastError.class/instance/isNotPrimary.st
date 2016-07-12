testing
isNotPrimary
	"A 'Not primary while performing...' error can be raised on update and remove operations."

	^ self codeIfPresent: [ :code | code = 10107 ] ifAbsent: [ false ]
