Extension { #name : #MongoDatabase }

{ #category : #'*Mongo-Pharo-Tools' }
MongoDatabase >> gtInspectorCollectionsIn: composite [
	<gtInspectorPresentationOrder: 40>
	<gtInspectorTag: #basic>	 
	<gtInspectorTag: #mongo>
	
 	composite list
		title: 'Collections';
      display: [ self collections ];
		icon: [ Smalltalk ui icons mongoCollectionIcon ];
      when: [ self collections notEmpty ]  
]

{ #category : #'*Mongo-Pharo-Tools' }
MongoDatabase >> spotterCollectionsFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Mongo Collections';
		allCandidates: [ self collections ];
		itemName: [ :collection | collection name asString ];
		itemIcon: [ :item | Smalltalk ui icons mongoCollectionIcon ];
		wantsToDisplayOnEmptyQuery: true



]
