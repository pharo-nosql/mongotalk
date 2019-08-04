tests
commandForTesting
	^ OrderedDictionary new
		at: 'find' put: collection name;
		at: 'filter' put: self baseDocumentForTesting;
		yourself