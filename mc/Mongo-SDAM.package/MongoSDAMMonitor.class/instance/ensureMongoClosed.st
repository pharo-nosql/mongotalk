private
ensureMongoClosed
	(mongo isNotNil and: [ mongo isOpen ]) ifTrue: [ mongo close ]