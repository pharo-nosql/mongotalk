"
A cursor for a query

Instance Variables
	query:		<Object>
	root:		<Object>

query
	- xxxxx

root
	- xxxxx

"
Class {
	#name : #MongoCursor,
	#superclass : #Object,
	#instVars : [
		'root',
		'query',
		'queryOperationFlags'
	],
	#category : #'Mongo-Core-Utilities'
}

{ #category : #'instance creation' }
MongoCursor class >> root: aMongo query: aMongoQuery [
	^self new
		root: aMongo;
		query: aMongoQuery.
]

{ #category : #private }
MongoCursor >> cursorQuery: aQuery [
	| id |

	id := self root nextRequestID.
	(aQuery operation
		id: id
			stream: self root stream
			query: aQuery)
		flags: aQuery flags;
		write.

	^ id
]

{ #category : #executing }
MongoCursor >> execute [

	self subclassResponsibility
]

{ #category : #accessing }
MongoCursor >> query [
	^ query
]

{ #category : #accessing }
MongoCursor >> query: anObject [

	query := anObject
]

{ #category : #accessing }
MongoCursor >> root [
	^ root
]

{ #category : #accessing }
MongoCursor >> root: anObject [
	root := anObject
]
