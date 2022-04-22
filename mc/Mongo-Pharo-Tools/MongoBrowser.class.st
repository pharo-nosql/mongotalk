"
A browser for a running mongo instance

	MongoBrowser open
"
Class {
	#name : #MongoBrowser,
	#superclass : #Object,
	#category : 'Mongo-Pharo-Tools-UI'
}

{ #category : #'world menu' }
MongoBrowser class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	(aBuilder item: #'Mongo Browser')
		parent: #Tools;
		action: [self open]; 
		icon: Smalltalk ui icons mongoIcon
]

{ #category : #'interface opening' }
MongoBrowser class >> open [
	<script>

	self openOn: Mongo default open 
]

{ #category : #'interface opening' }
MongoBrowser class >> openOn: aMongo [
	<script: 'MongoBrowser openOn: Mongo default open'>

	|inspector|
	inspector := GTInspector new.
	inspector title: 'Mongo Database browser'.
	inspector presentationFilter: (GTInspectorTagFilter new 
												defaultTag: #mongo;
												addAndSelectTag: #mongo).
	inspector openOn: aMongo 
]
