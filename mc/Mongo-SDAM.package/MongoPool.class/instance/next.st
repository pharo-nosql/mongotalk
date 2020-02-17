private
next
	"Answer an instance of Mongo that is open (and then ready to be used).
	Caller may return it to this pool after use (see #return:)."

	| mongo |
	mutex critical: [
		mongo := connections
			ifEmpty: [ Mongo url: url ]
			ifNotEmpty: [ connections removeFirst ] ].
	self ensureOpenMongo: mongo.
	^ mongo