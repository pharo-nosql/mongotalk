private
announceIfNeeded: aBlockThatValuesToAnAnnouncement
	self shouldAnnounce ifTrue: [
		announcer announce: aBlockThatValuesToAnAnnouncement value ]