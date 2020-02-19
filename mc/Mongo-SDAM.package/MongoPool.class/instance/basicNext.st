private
basicNext
	"Get a connection from the pool or create one"

	| mongo |
	mutex critical: [
		mongo := connections
			ifEmpty: [ Mongo url: url ]
			ifNotEmpty: [ connections removeFirst ] ].

	"Caller assumes it's open."
	self ensureOpenMongo: mongo.

	^ mongo