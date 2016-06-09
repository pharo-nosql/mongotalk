comparing
= anInteger
	anInteger isInteger ifFalse: [ MQQueryError signal: 'BSON type must be an Integer'].
	
	self right: anInteger