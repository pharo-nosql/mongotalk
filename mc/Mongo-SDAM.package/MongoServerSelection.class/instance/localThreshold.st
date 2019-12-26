accessing
localThreshold
	^ localThreshold ifNil: [ localThreshold := client localThreshold ]