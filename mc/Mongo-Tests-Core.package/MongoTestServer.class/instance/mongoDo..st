start/stop
mongoDo: aBlock
	| mongo timeout |
	timeout := 3 seconds.
	mongo := Mongo host: 'localhost' port: self port.
	mongo openWithTimeout: timeout.
	mongo socketTimeout: timeout.
	^ [ aBlock value: mongo ]
		ensure: [ mongo closeIfOpen ]