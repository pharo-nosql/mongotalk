converting
timeToBytes: aDateAndTime 
	^aDateAndTime asDuration asMilliseconds - self epoch asDuration asMilliseconds