accessing
flush
	monitor critical: [
		[ connections isEmpty ] whileFalse: [
			connections removeLast closeIfOpen ]]