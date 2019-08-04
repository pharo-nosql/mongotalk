tests
assertExpectedDocuments: aCollection
	self assert: aCollection size equals: self expectedDocumentCount.

	aCollection doWithIndex: [ :each :index |
		self baseDocumentForTesting keysAndValuesDo: [ :key :value |
			self assert: (each at: key) equals: value ].
		self assert: (each at: 'index') equals: index ].
