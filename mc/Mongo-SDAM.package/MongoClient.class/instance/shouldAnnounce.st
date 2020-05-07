testing
shouldAnnounce
	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]