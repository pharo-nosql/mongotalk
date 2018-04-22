converting
asKeysAndValuesInto: aDictionary
	self j ifNotNil: [:value | aDictionary at: 'j' put: value ].
	self w ifNotNil: [:value | aDictionary at: 'w' put: value ].
	self wtimeout ifNotNil: [:value | aDictionary at: 'wtimeout' put: value ]