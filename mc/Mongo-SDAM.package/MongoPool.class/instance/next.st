private
next
	| mongo |
	mutex critical: [
		mongo := connections
			ifEmpty: [ Mongo url: url ]
			ifNotEmpty: [ connections removeFirst ] ].
	self ensureOpenMongo: mongo.
	^ mongo