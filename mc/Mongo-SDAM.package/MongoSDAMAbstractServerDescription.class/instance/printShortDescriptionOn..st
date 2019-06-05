printing
printShortDescriptionOn: aStream
	aStream
		print: urlString;
		space;
		print: dateAndTime asDuration asMilliSeconds.