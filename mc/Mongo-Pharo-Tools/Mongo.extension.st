Extension { #name : #Mongo }

{ #category : #'*Mongo-Pharo-Tools' }
Mongo >> gtInspectorDatabasesIn: composite [
	<gtInspectorPresentationOrder: 40>
	<gtInspectorTag: #basic>	 
	<gtInspectorTag: #mongo>
	
 	composite list
		title: 'Databases';
      display: [ self databases ];
		icon: [ Smalltalk ui icons mongoDatabaseIcon ];
      when: [ self isOpen ]  
]
