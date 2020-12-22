accessing
err
	| result |
	result := (reply includesKey: '$err') ifTrue: [ reply at: '$err' ] ifFalse: [ reply at: 'errmsg' ].
	^ result