comparing
= anInteger
	anInteger isInteger ifFalse: [ MQQueryError signal: 'Array size must be an Integer'].
	
	self right: anInteger