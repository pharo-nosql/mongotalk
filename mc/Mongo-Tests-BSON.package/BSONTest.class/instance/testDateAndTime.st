tests
testDateAndTime
	| dateTime |

	dateTime := DateAndTime year: 2012 month: 11 day: 22 hour: 13 minute: 55 second: 12 offset: 0 asDuration.
	
	self encodeAndDecode: dateTime