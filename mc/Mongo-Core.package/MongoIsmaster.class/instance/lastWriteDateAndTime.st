accessing - replica set
lastWriteDateAndTime
	^ ((response at: 'lastWrite') at: 'lastWriteDate') asDateAndTime 