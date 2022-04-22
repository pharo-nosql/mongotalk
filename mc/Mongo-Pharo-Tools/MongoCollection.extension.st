Extension { #name : #MongoCollection }

{ #category : #'*Mongo-Pharo-Tools' }
MongoCollection >> gtInspectorDictionariesIn: composite [
	<gtInspectorPresentationOrder: 40>
	<gtInspectorTag: #basic>	 
	<gtInspectorTag: #mongo>
	
 	composite list
		title: 'Documents';
      display: [ self select: Dictionary new ];
		format: [:each | (each at: #_id) asString ];
		icon: [ Smalltalk ui icons mongoDocumentIcon ];
      when: [ (self select:  Dictionary new) notEmpty ]  
]

{ #category : #'*Mongo-Pharo-Tools' }
MongoCollection >> spotterDocumentsFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Mongo Documents';
		allCandidates: [ (self select: Dictionary new )];
		itemName: [ :document | (document at: #_id) asString ];
		itemIcon: [ :item | Smalltalk ui icons mongoDocumentIcon ];
		wantsToDisplayOnEmptyQuery: true



]
