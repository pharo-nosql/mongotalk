accessing
newMongoA

	^ Mongo 
		host: self mongoUrlA host 
		port: self mongoUrlA port