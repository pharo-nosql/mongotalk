"
Utilitiy class to overcome gratuitous incompatibilities 
"
Class {
	#name : #GratuitousIncompatibilities,
	#superclass : #Object,
	#classVars : [
		'UTF8Codec',
		'UTF8Converter'
	],
	#category : 'Mongo-Squeak'
}

{ #category : #accessing }
GratuitousIncompatibilities class >> codecNext: aGRCodecStream [ 
	^aGRCodecStream next
]

{ #category : #converting }
GratuitousIncompatibilities class >> compressLargeInteger: aLargeInteger [
	^aLargeInteger normalize 
]

{ #category : #converting }
GratuitousIncompatibilities class >> dateAndTimeToMilliseconds: aDateAndTime [
	^ (self dateToMilliseconds: aDateAndTime asUTC asDate) + aDateAndTime asUTC asTime asDuration asMilliseconds
]

{ #category : #converting }
GratuitousIncompatibilities class >> dateToMilliseconds: aDate [ 
	^(aDate - self epoch) asDuration asMilliseconds
]

{ #category : #converting }
GratuitousIncompatibilities class >> decodeString: aString [
	^self utf8Converter convertFromSystemString: aString
]

{ #category : #converting }
GratuitousIncompatibilities class >> doubleToBytes: aFloat [
	| writer lowWord highWord |
	writer := LittleEndianStream on: (ByteArray new: 8) writeStream.
	lowWord := aFloat basicAt: 2.
	writer nextInt32Put: lowWord.
	highWord := aFloat basicAt: 1.
	writer nextInt32Put: highWord.
	^writer contents
]

{ #category : #converting }
GratuitousIncompatibilities class >> encodeString: aString [
	^self utf8Converter convertToSystemString: aString
]

{ #category : #converting }
GratuitousIncompatibilities class >> epoch [
	^self newYear: 1970 day: 1
]

{ #category : #converting }
GratuitousIncompatibilities class >> intToDate: anInteger [ 
	^(self intToTime: anInteger) asDate - 1 day
]

{ #category : #converting }
GratuitousIncompatibilities class >> intToDateAndTime: anInteger [
	^(self intToTime: anInteger) 
]

{ #category : #converting }
GratuitousIncompatibilities class >> intToTime: anInteger [ 
	| sinceJavaEpoch |
	sinceJavaEpoch := Duration milliseconds: anInteger.
	^self epoch + sinceJavaEpoch
]

{ #category : #creation }
GratuitousIncompatibilities class >> newYear: yearInteger day: dayInteger [
	^DateAndTime year: yearInteger day: dayInteger hour: 0 minute: 0 second: 0 offset: Duration zero
]

{ #category : #converting }
GratuitousIncompatibilities class >> readDoubleFrom: aStream [
	| result |
	result := Float new: 2.
	result basicAt: 2 put: aStream nextUInt32.
	result basicAt: 1 put: aStream nextUInt32.
	^result
]

{ #category : #creation }
GratuitousIncompatibilities class >> socketStreamHost: aString port: anInteger [ 
	| result |
	result := SocketStream openConnectionToHostNamed: aString port: anInteger.
	result binary.
	^result
]

{ #category : #converting }
GratuitousIncompatibilities class >> timeToBytes: aDateAndTime [ 
	^aDateAndTime asDuration asMilliseconds - self epoch asDuration asMilliseconds
]

{ #category : #converting }
GratuitousIncompatibilities class >> timeToMilliseconds: aDateAndTime [ 
	^aDateAndTime asDuration asMilliseconds 
]

{ #category : #creation }
GratuitousIncompatibilities class >> utf8Codec [
	^UTF8Codec ifNil: [ UTF8Codec := GRCodec forEncoding: 'utf8']
]

{ #category : #accessing }
GratuitousIncompatibilities class >> utf8Converter [ 
	^UTF8Converter ifNil: [ UTF8Converter := UTF8TextConverter default ] 
]
