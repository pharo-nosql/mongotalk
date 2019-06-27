private
ensureMongoClosed
	(checkMongo isNotNil and: [ checkMongo isOpen ]) ifTrue: [ checkMongo close ]