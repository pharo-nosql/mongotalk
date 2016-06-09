private
nextValueForType: anInteger 
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