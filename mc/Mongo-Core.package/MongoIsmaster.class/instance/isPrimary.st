testing
isPrimary
	^ (response at: 'ismaster') == true