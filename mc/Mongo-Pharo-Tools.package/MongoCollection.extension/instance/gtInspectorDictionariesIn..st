*Mongo-Pharo-Tools
gtInspectorDictionariesIn: composite
	<gtInspectorPresentationOrder: 40>
	<gtInspectorTag: #basic>	 
	<gtInspectorTag: #mongo>
	
 	composite list
		title: 'Documents';
      display: [ self select: Dictionary new ];
		format: [:each | (each at: #_id) asString ];
		icon: [ Smalltalk ui icons mongoDocumentIcon ];
      when: [ (self select:  Dictionary new) notEmpty ]  