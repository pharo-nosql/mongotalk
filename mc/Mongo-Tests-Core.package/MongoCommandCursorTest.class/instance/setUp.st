running
setUp
	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
	collection := database getCollection: 'testCollection'.

	documents := (1 to: self expectedDocumentCount) collect: [:index |
		self baseDocumentForTesting
			at: 'index' put: index;
			yourself ].
	documents do: [ :each | collection add: each ].