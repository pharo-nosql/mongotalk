start/stop
mongoDo: aBlock
	| mongo |
	mongo := Mongo host: 'localhost' port: self port.
	mongo openWithTimeout: 1 second.
	mongo socketTimeout: 1 second.
	[ ^ aBlock value: mongo ]
		ensure: [ mongo closeIfOpen ]