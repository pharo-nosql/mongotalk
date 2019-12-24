accessing
addMember: id port: port priority: priority
	"Specify a mongod that will be started on #start. All arguments should be numbers."
	
	members add: {
		 	'_id' -> id.
			'host' -> ('localhost:', port asString).
			'priority' -> priority
		} asOrderedDictionary