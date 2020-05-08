accessing
readPreference
	^ readPreference ifNil: [ readPreference := client settings readPreference ]