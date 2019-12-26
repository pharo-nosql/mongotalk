private
writeWithRetry
	[ 	self writeToPrimary.
		Transcript show: '-> write done'; cr.
	] 	on: Error
		do: [ :firstError |
			"second try"
			Transcript show: '-> retry write ('; print: firstError; show: ')'; cr.
			[ 
				self writeToPrimary.
				Transcript show: '---> retry write success'; cr 
			]	on: Error
				do: [ :secondError |
					Transcript show: '---> retry write failed ('; print: secondError; show: ')'; cr ]
		]