accessing
localThreshold
	^ localThreshold ifNil: [ localThreshold := client settings localThreshold ]