accessing
flush
	monitor critical: [
		[ connections isEmpty ] whileFalse: [
			self ensureCloseMongo: connections removeLast ]]