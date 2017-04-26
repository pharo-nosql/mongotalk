private
wtimeoutValue
	^ wtimeout = 0
		ifTrue: [ nil ]
		ifFalse: [ wtimeout ]