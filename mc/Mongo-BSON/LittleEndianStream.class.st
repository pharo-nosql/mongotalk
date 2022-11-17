"
<smalltalkDoc xmlns=""http://www.stic.org/smalltalkDoc/"">
<comment></comment>
</smalltalkDoc>
"
Class {
	#name : #LittleEndianStream,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Mongo-BSON-Utilities'
}

{ #category : #'instance creation' }
LittleEndianStream class >> on: aReadStream [ 
	^self new setReader: aReadStream
]

{ #category : #accessing }
LittleEndianStream >> contents [
	^stream contents
]

{ #category : #writing }
LittleEndianStream >> encode: aString [
	^ ZnUTF8Encoder default encodeString: aString
]

{ #category : #writing }
LittleEndianStream >> flush [
	stream flush
]

{ #category : #reading }
LittleEndianStream >> nextByte [
	"Worry about sign? What sayeth the spec?"

	^stream next
]

{ #category : #writing }
LittleEndianStream >> nextBytePut: anInteger [ 
	stream nextPut: anInteger
]

{ #category : #reading }
LittleEndianStream >> nextBytes: anInteger [

	^stream next: anInteger
]

{ #category : #writing }
LittleEndianStream >> nextBytesPut: aByteArray [ 
	stream nextPutAll: aByteArray
]

{ #category : #writing }
LittleEndianStream >> nextEncodedStringPut: aByteArray [ 
	self 
		nextBytesPut: aByteArray;
		null
]

{ #category : #reading }
LittleEndianStream >> nextInt32 [
	| unsigned |
	unsigned := self nextUInt32.
	^unsigned <= ((2 raisedTo: 31) - 1)
		ifTrue: [unsigned]
		ifFalse: [((2 raisedTo: 32) - unsigned) negated]
]

{ #category : #writing }
LittleEndianStream >> nextInt32Put: anInteger [ 
	self nextBytePut: (anInteger bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -8) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -16) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -24) bitAnd: 16rFF)
]

{ #category : #reading }
LittleEndianStream >> nextInt64 [
	| unsigned |
	unsigned := stream next + (stream next bitShift: 8) + (stream next bitShift: 16) + (stream next bitShift: 24) + (stream next bitShift: 32) + (stream next bitShift: 40) + (stream next bitShift: 48) + (stream next bitShift: 56).
	^unsigned <= ((2 raisedTo: 63) - 1)
		ifTrue: [unsigned]
		ifFalse: [((2 raisedTo: 64) - unsigned) negated]
]

{ #category : #writing }
LittleEndianStream >> nextInt64Put: anInteger [ 
	self nextBytePut: (anInteger bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -8) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -16) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -24) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -32) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -40) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -48) bitAnd: 16rFF).
	self nextBytePut: ((anInteger bitShift: -56) bitAnd: 16rFF)
]

{ #category : #writing }
LittleEndianStream >> nextSizedStringPut: aString [
	| encoded |
	encoded := self encode: aString.
	self nextInt32Put: encoded size + 1.	"For terminating null"
	self nextEncodedStringPut: encoded
]

{ #category : #reading }
LittleEndianStream >> nextString [
	| bytes |

	bytes := stream upTo: 0.
	^ bytes utf8Decoded asString
]

{ #category : #reading }
LittleEndianStream >> nextString: aNumber [
	| string |

	string := stream next: (aNumber - 1).
	stream skip: 1.
	^ string utf8Decoded
]

{ #category : #writing }
LittleEndianStream >> nextStringPut: aString [ 
	| encoded |
"	encoder := UTF8StreamEncoder new.
	aString do: [:each | encoder nextPut: each on: stream]."
	encoded := self encode: aString.
	self nextEncodedStringPut: encoded 
]

{ #category : #reading }
LittleEndianStream >> nextUInt32 [
	^stream next + (stream next bitShift: 8) + (stream next bitShift: 16) + (stream next bitShift: 24)
]

{ #category : #writing }
LittleEndianStream >> null [
	self nextBytePut: 0
]

{ #category : #accessing }
LittleEndianStream >> position [
	^stream position
]

{ #category : #accessing }
LittleEndianStream >> position: anInteger [ 
	stream position: anInteger
]

{ #category : #private }
LittleEndianStream >> setReader: aReadStream [ 
	stream := aReadStream
]

{ #category : #private }
LittleEndianStream >> skip: aNumber [
	stream skip: aNumber
]
