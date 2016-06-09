forwarding
doesNotUnderstand: aMessage
	^ aMessage selector isUnary
		ifTrue: [ self at: aMessage selector ]
		ifFalse: [ super doesNotUnderstand: aMessage ]