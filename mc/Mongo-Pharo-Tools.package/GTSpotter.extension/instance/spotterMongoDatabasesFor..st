*Mongo-Pharo-Tools
spotterMongoDatabasesFor: aStep
	<spotterOrder: 10>
	
	^ aStep listProcessor 
		title: 'Mongo databases';
		candidatesLimit: Float infinity;
		allCandidates: [ 
			Mongo default isAvailable 
									ifFalse: [ #() ]
									ifTrue: [ Mongo default open databases ]];
		itemName: [:item | item name ];
		itemIcon: [:item | Smalltalk ui icons mongoDatabaseIcon ];
		matchSubstring