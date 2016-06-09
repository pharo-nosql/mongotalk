converting
dateAndTimeToMilliseconds: aDateAndTime
	^ (self dateToMilliseconds: aDateAndTime asUTC asDate) + aDateAndTime asUTC asTime asDuration asMilliseconds