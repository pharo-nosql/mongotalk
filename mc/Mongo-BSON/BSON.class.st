"
<smalltalkDoc xmlns=""http://www.stic.org/smalltalkDoc/"">
<comment></comment>
</smalltalkDoc>
"
Class {
	#name : #BSON,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : 'Mongo-BSON-Base'
}

{ #category : #codec }
BSON class >> read: aStream [
	| reader |
	reader := LittleEndianStream on: aStream.
	^(self new setStream: reader) nextDictionary
]

{ #category : #codec }
BSON class >> write: aDictionary [ 
	^self writer 
		nextDictionaryPut: aDictionary; 
		contents
]

{ #category : #codec }
BSON class >> writeAll: aCollection [ 
	| writer |
	writer := self writer.
	aCollection do: [:each | writer nextDictionaryPut: each].
	^writer contents
]

{ #category : #'instance creation' }
BSON class >> writer [
	^self new setStream: (LittleEndianStream on: ByteArray new writeStream)
]

{ #category : #private }
BSON >> addObjectType: anInteger to: aDictionary [
	aDictionary 
		at: self nextKey
		put: (self nextValueForType: anInteger)
]

{ #category : #writing }
BSON >> basicNextDictionaryPut: aCollection [
	| start end |
	start := stream position.
	stream nextInt32Put: 0.	"Just to make space"
	aCollection do: [:each | each writeBSONOn: self].
	stream null.
	end := stream position.
	stream position: start.
	stream nextInt32Put: end - start.
	stream position: end
]

{ #category : #accessing }
BSON >> contents [
	^stream contents
]

{ #category : #testing }
BSON >> isInt32: anInteger [
	^anInteger between: (2 raisedTo: 31) negated and: (2 raisedTo: 31) - 1
]

{ #category : #testing }
BSON >> isInt64: anInteger [
	^anInteger between: (2 raisedTo: 63) negated and: (2 raisedTo: 63) - 1
]

{ #category : #reading }
BSON >> nextArray [
	| elements results index |
	elements := self nextDictionary.
	results := Array new: elements size.
	index := 1.
	elements associationsDo: [ :eachAssociation | 
		results at: (eachAssociation key asNumber +1) put: eachAssociation value.
		index := index + 1].
	^results
]

{ #category : #writing }
BSON >> nextArrayPut: anArray [
	| elements start end |
	elements := SmallDictionary new.
	anArray
		keysAndValuesDo: [:eachKey :eachValue | elements at: (eachKey - 1) printString put: eachValue].
	start := stream position.
	stream nextInt32Put: 0.	"Just to make space"
	elements associations do: [:each | each writeBSONOn: self].
	stream null.
	end := stream position.
	stream position: start.
	stream nextInt32Put: end - start.
	stream position: end
]

{ #category : #writing }
BSON >> nextAssociationPut: anAssociation [ 
	stream nextBytePut: (self typeCode: anAssociation value).
	self nextStringPut: anAssociation key.
	anAssociation value writeBSONOn: self
]

{ #category : #reading }
BSON >> nextBinary [
	| size  subType |
	size := stream nextUInt32.
	subType := stream nextByte. "sub type byte"
	"current spec states subType = 3 as old and the actual subType as 4. We handle both
	so a conversion is easier"
	(subType == 3) | (subType == 4) ifTrue: [ ^ self nextUUID: (stream nextBytes: size) ].
	^ stream nextBytes: size 
]

{ #category : #reading }
BSON >> nextBoolean [
	^stream nextByte = 1
]

{ #category : #writing }
BSON >> nextBooleanPut: aBoolean [
	stream nextBytePut: (aBoolean ifTrue: [1] ifFalse: [0])
]

{ #category : #writing }
BSON >> nextByteArrayPut: aByteArray [
	stream 
		nextInt32Put: aByteArray size;
		nextBytePut: 0; "Subtype: Binary / Generic"
		nextBytesPut: aByteArray
]

{ #category : #reading }
BSON >> nextDate [
	^(GratuitousIncompatibilities intToDate: stream nextInt64)
]

{ #category : #reading }
BSON >> nextDateAndTime [
	^(GratuitousIncompatibilities intToDateAndTime: stream nextInt64)
]

{ #category : #writing }
BSON >> nextDateAndTimePut: aDateAndTime [
	stream nextInt64Put: (GratuitousIncompatibilities dateAndTimeToMilliseconds: aDateAndTime)
]

{ #category : #writing }
BSON >> nextDatePut: aDate [ 
	stream nextInt64Put: (GratuitousIncompatibilities dateToMilliseconds: aDate)
]

{ #category : #reading }
BSON >> nextDictionary [
	| result byteSize |
	result := Dictionary new.
	byteSize := stream nextUInt32.
	[| type |
	type := stream nextByte.
	type = 0 ifTrue: [^result].
	self addObjectType: type to: result]
		repeat.
	^BSONError signal: 'Attempt to read off end of stream'
]

{ #category : #writing }
BSON >> nextDictionaryPut: aDictionary [
	"write associations sorted and having the _id field in first place. This is kept for 
	legacy reasons although the necessity for having fields sorted is not obvious"
	self basicNextDictionaryPut: (
		aDictionary associations 
			asSortedCollection: [:a :b | a key = '_id' | (a key < b key)]) 
]

{ #category : #reading }
BSON >> nextDouble [
	^GratuitousIncompatibilities readDoubleFrom: stream
]

{ #category : #writing }
BSON >> nextDoublePut: aDouble [ 
	stream nextBytesPut: (GratuitousIncompatibilities doubleToBytes: aDouble)
]

{ #category : #reading }
BSON >> nextInt32 [
	^stream nextInt32
]

{ #category : #reading }
BSON >> nextInt64 [
	^stream nextInt64
]

{ #category : #writing }
BSON >> nextIntegerPut: anInteger [
	"Seems like this belongs here instead of the caller or the stream, but not certain"

	(self isInt32: anInteger) ifTrue: [^stream nextInt32Put: anInteger].
	(self isInt64: anInteger) ifTrue: [^stream nextInt64Put: anInteger].
	BSONError signal: 'Integer too large: ' , anInteger printString
]

{ #category : #reading }
BSON >> nextKey [
	^stream nextString
]

{ #category : #reading }
BSON >> nextNil [
	^nil
]

{ #category : #writing }
BSON >> nextNilPut [
	"This method intentionally if reluctantly left blank"
]

{ #category : #reading }
BSON >> nextOID [
	"read ObjectId from stream. ObjectId is encoded big-endian"
	| value |
	value := LargePositiveInteger basicNew: 12.
	12 timesRepeat: [
		value := (value bitShift: 8) bitOr: stream nextByte ].
	^OID value: (GratuitousIncompatibilities compressLargeInteger: value)
]

{ #category : #writing }
BSON >> nextOIDPut: anOID [ 
	"write ObjectId to stream. ObjectId is encoded big-endian"
	| value |
	value := anOID value.
	12 to: 1 by: -1 do: [:digitIndex |
		stream nextBytePut: (value byteAt: digitIndex)]
]

{ #category : #writing }
BSON >> nextOrderedDictionaryPut: aDictionary [
	"write associations as they are in the dictionary. This supports dictionaries that
	have special order.  Mongo is looking up some of the key-value based collections 
	in order and not by key. This is rather important for dictionaries that form queries 
	than for the ones that are supposed to be stored"
	self basicNextDictionaryPut:  aDictionary associations
]

{ #category : #reading }
BSON >> nextRegex [ 
	^RxParser safelyParse: self nextSizedString
]

{ #category : #writing }
BSON >> nextRegexPut: aBSONRegex [
	stream nextStringPut: aBSONRegex value
]

{ #category : #reading }
BSON >> nextSizedString [
	| size result  |
	size := stream nextUInt32.
	^ stream nextString: size
]

{ #category : #writing }
BSON >> nextSizedStringPut: aString [
	| encoded |
	encoded := stream encode: aString.
	stream nextInt32Put: encoded size + 1.	"For terminating null"
	stream nextBytesPut: encoded asByteArray.
	stream null
]

{ #category : #writing }
BSON >> nextStringPut: aByteString [
	stream nextStringPut: aByteString
]

{ #category : #reading }
BSON >> nextSymbol [
	^self nextSizedString asSymbol
]

{ #category : #writing }
BSON >> nextSymbolPut: aByteSymbol [ 
	self nextSizedStringPut: aByteSymbol
]

{ #category : #reading }
BSON >> nextTimestamp [
	^MongoTimeStamp value: self nextInt64
]

{ #category : #writing }
BSON >> nextTimestampPut: aMongoTimeStamp [ 
	stream nextInt64Put: aMongoTimeStamp value
]

{ #category : #reading }
BSON >> nextUUID: aByteArray [ 
	^ UUID newFrom: aByteArray
]

{ #category : #writing }
BSON >> nextUUIDPut: aUUID [
	stream 
		nextInt32Put: aUUID size;
		"write new UUIDs with the actual assigned subtype"
		nextBytePut: 4;
		nextBytesPut: aUUID 
]

{ #category : #reading }
BSON >> nextUndefined [
	"Not sure what I should reply here"
	^nil
]

{ #category : #private }
BSON >> nextValueForType: anInteger [ 
	"Uglyness for performance"
	anInteger == 7 		ifTrue: [ ^self nextOID ].
	anInteger == 2 		ifTrue: [ ^self nextSizedString ].
	anInteger == 10 	ifTrue: [ ^self nextNil ].
	anInteger == 8 		ifTrue: [ ^self nextBoolean ].
	anInteger == 16 	ifTrue: [ ^self nextInt32 ].
	anInteger == 18 	ifTrue: [ ^self nextInt64 ].
	anInteger == 1 		ifTrue: [ ^self nextDouble ].
	anInteger == 4 		ifTrue: [ ^self nextArray ].
	anInteger == 3 		ifTrue: [ ^self nextDictionary ].
	anInteger == 14 	ifTrue: [ ^self nextSymbol ].
	anInteger == 9 		ifTrue: [ ^self nextDateAndTime ].
	anInteger == 17 	ifTrue: [ ^self nextTimestamp ].
	anInteger == 6 		ifTrue: [ ^self nextUndefined ].
	anInteger == 11 	ifTrue: [ ^self nextRegex ].
	anInteger == 5 		ifTrue: [ ^self nextBinary ].

	BSONUndefindedType signalCode: anInteger.
]

{ #category : #writing }
BSON >> nextWideStringPut: aWideString [ 
	self nextSizedStringPut: aWideString
]

{ #category : #private }
BSON >> setStream: aStream [
	stream := aStream
]

{ #category : #accessing }
BSON >> typeCode: anObject [
	^anObject bsonTypeCode
]
