start/stop
mongoDo: aBlock
	| mongo |
	mongo := Mongo host: 'localhost' port: port.
	mongo openWithTimeout: self timeout.
	mongo socketTimeout: self timeout.
	^ [ aBlock value: mongo ]
		ensure: [ mongo closeIfOpen ]