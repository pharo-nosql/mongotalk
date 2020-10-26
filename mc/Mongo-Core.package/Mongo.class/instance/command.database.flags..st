operations
command: anOrderedDictionary database: aDatabase flags: flags
	| query reply |
	query := MongoQuery new
		database: aDatabase;
		collection: MongoCollection cmdVirtualCollection;
		where: anOrderedDictionary;
		operation: CommandOperation;
		flags: flags;
		yourself.

	reply := self queryOne: query.

	(reply at: 'ok' ifAbsent: [ self error ]) = 1.0 
		ifFalse: [ MongoCommandError signalFor: reply ].
		
	^ reply