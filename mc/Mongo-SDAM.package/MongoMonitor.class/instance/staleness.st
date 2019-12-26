accessing
staleness
	^ latestServerDescription isSuccess
		ifTrue: [ latestServerDescription staleness ]
		ifFalse: [ self error: 'Cannot know' ]
