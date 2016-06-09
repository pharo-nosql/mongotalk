*Mongo-Pharo-Tools
gtInspectorCollectionsIn: composite
	<gtInspectorPresentationOrder: 40>
	<gtInspectorTag: #basic>	 
	<gtInspectorTag: #mongo>
	
 	composite list
		title: 'Collections';
      display: [ self collections ];
		icon: [ Smalltalk ui icons mongoCollectionIcon ];
      when: [ self collections notEmpty ]  