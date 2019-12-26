accessing
readPreference
	^ readPreference ifNil: [ readPreference := client readPreference ]