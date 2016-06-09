*Mongo-Pharo-Tools
spotterDocumentsFor: aStep
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Mongo Documents';
		allCandidates: [ (self select: Dictionary new )];
		itemName: [ :document | (document at: #_id) asString ];
		itemIcon: [ :item | Smalltalk ui icons mongoDocumentIcon ];
		wantsToDisplayOnEmptyQuery: true


