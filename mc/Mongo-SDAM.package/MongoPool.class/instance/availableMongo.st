private
availableMongo
	^ monitor critical: [ 
		connections
			ifEmpty: [ self newOpenMongo ]
			ifNotEmpty: [ 
				| mongo |
				mongo := connections removeFirst.
				self ensureOpenMongo: mongo.
				mongo ] ]