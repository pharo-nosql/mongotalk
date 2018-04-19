converting
asKeysAndValuesInto: aDictionary
	j ifNotNil: [ aDictionary at: 'j' put: j ].
	w ifNotNil: [ aDictionary at: 'w' put: w ].
	wtimeout ifNotNil: [ aDictionary at: 'wtimeout' put: wtimeout ]