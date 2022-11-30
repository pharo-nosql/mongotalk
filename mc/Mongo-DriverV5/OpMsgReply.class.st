"
Implementation of OP_MSG for replies.
"
Class {
	#name : #OpMsgReply,
	#superclass : #OpMSG,
	#instVars : [
		'responseTo',
		'sections',
		'size'
	],
	#category : #'Mongo-DriverV5-Operations'
}

{ #category : #'instance creation' }
OpMsgReply class >> fromStream: aStream [

	^ self new fromStream: aStream
]

{ #category : #enumerating }
OpMsgReply >> do: aBlock [

	sections 
		collect: [ :each | each document ]
		thenDo: aBlock
]

{ #category : #initialization }
OpMsgReply >> fromStream: aStream [
	| stream opCode flags remainingSize |

	stream := LittleEndianStream on: aStream.
	"header"
	size := stream nextInt32.
	id := stream nextInt32.
	responseTo := stream nextInt32.	
	opCode := stream nextInt32.
	"extra"
	flags := stream nextInt32.
	self flag: #TODO. "verify if there is checksum (and remove it from remaining size)"

	"sections"
	sections := OrderedCollection new.	
	remainingSize := size - self fixedHeaderSize - 4.
	[ remainingSize > 0 ]
	whileTrue: [ 
		| section |
		section := self readSection: stream size: remainingSize.
		sections add: section.
		remainingSize := remainingSize - section size ]
]

{ #category : #testing }
OpMsgReply >> isFinished [
	
	^ (sections first document at: 'cursor' at: 'id') = 0
]

{ #category : #private }
OpMsgReply >> messageSize [

	^ size
]

{ #category : #initialization }
OpMsgReply >> readSection: stream size: aSize [
 	
	^ OpMsgSection 
		fromStream: stream 
		size: aSize
]

{ #category : #accessing }
OpMsgReply >> responseTo [

	^ responseTo
]
