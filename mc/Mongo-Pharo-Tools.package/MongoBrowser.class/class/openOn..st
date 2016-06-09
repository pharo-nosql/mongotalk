interface opening
openOn: aMongo
	<script: 'MongoBrowser openOn: Mongo default open'>

	|inspector|
	inspector := GTInspector new.
	inspector title: 'Mongo Database browser'.
	inspector presentationFilter: (GTInspectorTagFilter new 
												defaultTag: #mongo;
												addAndSelectTag: #mongo).
	inspector openOn: aMongo 