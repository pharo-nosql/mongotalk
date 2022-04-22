"
I represent the description of a mongodb server. See my subclasses.
"
Class {
	#name : #MongoAbstractServerDescription,
	#superclass : #Object,
	#instVars : [
		'urlString',
		'dateAndTime'
	],
	#category : 'Mongo-Client-Topology'
}

{ #category : #accessing }
MongoAbstractServerDescription >> dateAndTime [
	^ dateAndTime
]

{ #category : #initialization }
MongoAbstractServerDescription >> dateAndTime: aDateAndTime [
	dateAndTime := aDateAndTime
]

{ #category : #accessing }
MongoAbstractServerDescription >> differencesFrom: anotherMongoServerDescription do: aBlockClosure [
	self class = anotherMongoServerDescription class ifFalse: [
		aBlockClosure
			cull: #class
			cull: anotherMongoServerDescription class -> self class ]
]

{ #category : #testing }
MongoAbstractServerDescription >> hasDifferenceWith: anotherMongoServerDescription [
	self differencesFrom: anotherMongoServerDescription do: [ ^ true ].
	^ false
]

{ #category : #initialization }
MongoAbstractServerDescription >> initializeUrlString: aUrlString [
	self initialize.
	urlString := aUrlString.
	dateAndTime := DateAndTime now
]

{ #category : #testing }
MongoAbstractServerDescription >> isError [
	^ false
]

{ #category : #testing }
MongoAbstractServerDescription >> isSuccess [
	^ false
]

{ #category : #printing }
MongoAbstractServerDescription >> printOn: aStream [
	super printOn: aStream.

	aStream nextPut: $(.
	self printShortDescriptionOn: aStream.
	aStream nextPut: $)
]

{ #category : #printing }
MongoAbstractServerDescription >> printShortDescriptionOn: aStream [
	aStream nextPutAll: urlString.
	self isSuccess ifFalse: [ aStream nextPutAll: ' FAILED' ].
]

{ #category : #accessing }
MongoAbstractServerDescription >> url [
	^ urlString asMongoUrl
]

{ #category : #accessing }
MongoAbstractServerDescription >> urlString [
	^ urlString
]
