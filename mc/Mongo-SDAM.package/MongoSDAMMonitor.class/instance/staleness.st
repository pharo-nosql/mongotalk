accessing
staleness
	^ (latestServerDescription isNil or: [ latestServerDescription isSuccess not ])
		ifTrue: [ self error: 'Cannot know' ]
		ifFalse: [ latestServerDescription staleness ]