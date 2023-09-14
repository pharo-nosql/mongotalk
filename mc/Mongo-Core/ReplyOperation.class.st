"
A reply operation
"
Class {
	#name : #ReplyOperation,
	#superclass : #Object,
	#instVars : [
		'stream',
		'cursorId',
		'startingFrom',
		'returnCount',
		'responseTo',
		'id'
	],
	#category : #'Mongo-Core-Operations'
}

{ #category : #'instance creation' }
ReplyOperation class >> stream: aStream [
	^self new setStream: aStream 
]

{ #category : #accessing }
ReplyOperation >> cursorId [
	^cursorId
]

{ #category : #enumerating }
ReplyOperation >> do: aBlock [
	returnCount timesRepeat: [aBlock value: (BSON read: stream)]
]

{ #category : #testing }
ReplyOperation >> isFinished [
	^cursorId = 0
]

{ #category : #reading }
ReplyOperation >> read [
	| formatter size opCode responseFlag |
	
	formatter := LittleEndianStream on: stream.
	size := formatter nextInt32.
	id := formatter nextInt32.
	responseTo := formatter nextInt32.
	opCode := formatter nextInt32.	"should be 1"
	responseFlag := formatter nextInt32.	"should be 0"
	cursorId := formatter nextInt64.
	startingFrom := formatter nextInt32.
	returnCount := formatter nextInt32	"Element count"
]

{ #category : #accessing }
ReplyOperation >> responseTo [
	^ responseTo
]

{ #category : #accessing }
ReplyOperation >> returnCount [
	^returnCount 
]

{ #category : #private }
ReplyOperation >> setStream: aStream [
	stream := aStream
]
