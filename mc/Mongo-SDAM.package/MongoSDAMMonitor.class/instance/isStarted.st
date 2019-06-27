accessing
isStarted
	^ process notNil and: [ process isTerminated not ]