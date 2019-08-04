operations
databaseNames
	^ self listDatabases collect: [:each | each at: 'name' ]