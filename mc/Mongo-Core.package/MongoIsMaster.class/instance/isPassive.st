testing
isPassive
	^ response at: 'passive' ifAbsent: [ false ]