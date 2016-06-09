converting
dateToMilliseconds: aDate 
	^(aDate - self epoch) asDuration asMilliseconds