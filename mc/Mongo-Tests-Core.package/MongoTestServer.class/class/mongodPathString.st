accessing
mongodPathString
	^ mongodPathString ifNil: [ '/usr/bin/mongod' ]