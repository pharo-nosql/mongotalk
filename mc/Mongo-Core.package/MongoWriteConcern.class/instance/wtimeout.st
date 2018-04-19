accessing
wtimeout
	"Answer the 'wtimeout' option of this mongodb write concern. See #wtimeout:"
	
	^ wtimeout = 0
		ifTrue: [ nil ]
		ifFalse: [ wtimeout ]