*Mongo-Pharo-Tools
spotterCollectionsFor: aStep
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Mongo Collections';
		allCandidates: [ self collections ];
		itemName: [ :collection | collection name asString ];
		itemIcon: [ :item | Smalltalk ui icons mongoCollectionIcon ];
		wantsToDisplayOnEmptyQuery: true


