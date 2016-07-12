testing
isNotMaster
	"A 'not master' error can be raised on insert operations."
	
	^ self codeIfPresent: [ :code | code = 10058 ] ifAbsent: [ false ]