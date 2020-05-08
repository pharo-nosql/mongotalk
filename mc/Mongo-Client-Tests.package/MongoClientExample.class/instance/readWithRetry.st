private
readWithRetry
	[ 	self oneShotReadSlaveOk.
		Transcript show: '-> read done'; cr.
	] 	on: Error
		do: [ :firstError |
			"second try"
			Transcript show: '-> retry read ('; print: firstError; show: ')'; cr.
			[ 
				self oneShotReadSlaveOk.
				Transcript show: '---> retry read success'; cr 
			]	on: Error
				do: [ :secondError |
					Transcript show: '---> retry read failed ('; print: secondError; show: ')'; cr ]
		]