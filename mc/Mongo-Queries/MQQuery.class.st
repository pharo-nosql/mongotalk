"
A mongo query

Instance Variables
	label:		<Object>

label
	- xxxxx

"
Class {
	#name : #MQQuery,
	#superclass : #Object,
	#instVars : [
		'label'
	],
	#category : 'Mongo-Queries-Base'
}

{ #category : #accessing }
MQQuery >> at: aString [
	^ self fieldNamed: aString asString
]

{ #category : #forwarding }
MQQuery >> doesNotUnderstand: aMessage [
	^ aMessage selector isUnary
		ifTrue: [ self at: aMessage selector ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
]

{ #category : #accessing }
MQQuery >> fieldNamed: aString [
	^ MQField labelled: aString
]

{ #category : #forwarding }
MQQuery >> name [
	^ self at: 'name'
]

{ #category : #accessing }
MQQuery >> where: aString [
	^ MQWhereCondition javascript: aString
]
