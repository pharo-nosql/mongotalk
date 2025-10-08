Class {
	#name : 'MongoCCursorQuery',
	#superclass : 'MongoCursor',
	#instVars : [
		'code'
	],
	#category : 'Mongo-DriverC-Base',
	#package : 'Mongo-DriverC',
	#tag : 'Base'
}

{ #category : 'private' }
MongoCCursorQuery >> driver [

	^ self root
]

{ #category : 'executing' }
MongoCCursorQuery >> execute [
	| cursor |

	[ 
		cursor := self cursorQuery: self query.
		self query doBlock ifNotNil: [ :aBlock |
			self driver 
				forEachDocumentInCursor: cursor 
				do: [ :each | aBlock value: each ] ] ]
	ensure: [
		LibMongoc uniqueInstance cursor_destroy: cursor ]
]
