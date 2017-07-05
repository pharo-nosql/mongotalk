operations
command: anOrderedDictionary database: aDatabase
	| query reply |
	query := MongoQuery new
		database: aDatabase;
		collection: (MongoMetaCollection name: '$cmd');
		where: anOrderedDictionary;
		operation: CommandOperation;
		yourself.

	reply := self queryOne: query.

	(reply at: 'ok' ifAbsent: [ self error ]) = 1.0 
		ifFalse: [ MongoCommandError signalFor: reply ].
		
	^ reply