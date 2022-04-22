"
An OID as defined in http://docs.mongodb.org/manual/reference/object-id/

It has four fields;
- A 4 byte timestamp field, in seconds since Unix epoch.
- A 3 byte ""machine identifier"".
- A 2 byte process id.
-  A 3 byte counter.
"
Class {
	#name : #OID,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#classVars : [
		'NumberGenerator'
	],
	#classInstVars : [
		'counter',
		'machineIdentifier'
	],
	#category : 'Mongo-BSON-Base'
}

{ #category : #accessing }
OID class >> counterNext [ 
	"increase the 24 bit counter and return"
	^ counter := counter 
						ifNil:[counter := self newCounter] 
						ifNotNil:[counter + 1 \\ 16rFFFFFF]
]

{ #category : #initialize }
OID class >> initialize [
	self reset.
	Smalltalk addToShutDownList: self
]

{ #category : #accessing }
OID class >> machineIdentifier [
	^ machineIdentifier ifNil: [ machineIdentifier := self newMachineIdentifier ]

]

{ #category : #resetting }
OID class >> newCounter [
	"A new 3-byte counter, initialized to a random value, as per the spec."
	"Abuse the fact that we use a type4 UUID as machine identifier, and copy some of the random unused bits from that."
	^(LargePositiveInteger new: 3) 
		replaceFrom: 1 to:3 with: self machineIdentifier startingAt: 4; 
		normalize.
]

{ #category : #resetting }
OID class >> newMachineIdentifier [
	"Used to be an MD5 hash of local hostname, but that primitive always returns 'localhost' on at least Macs...
	Use a UUID instead, it will be different for the same machine after restarts, but the OID should never be used to identify a documents origin anyways."
	^ UUID new
]

{ #category : #'instance creation' }
OID class >> nextOID [
	^ self new
]

{ #category : #resetting }
OID class >> reset [
	<script>
	machineIdentifier := nil.
	counter := nil.
	
]

{ #category : #'startup-shutdown' }
OID class >> shutDown: quitting [
	"reset counter and machine identifier on image save. We want at least calculate a new
	machine identifier if the image started somewhere else"
	self reset
]

{ #category : #'instance creation' }
OID class >> value: anInteger [ 
	^self basicNew setValue: anInteger
]

{ #category : #comparing }
OID >> = anObject [
	^anObject class = self class and: [anObject value = self value]
]

{ #category : #mongo }
OID >> bsonTypeCode [
	^ 7
]

{ #category : #comparing }
OID >> hash [
	^ value hash
]

{ #category : #initialize }
OID >> initialize [
	"initialize value corresponding to the mongo spec. It is a 12-byte value containing:
	* 4-byte timestamp
	* 3-byte machine identifier
	* 2-byte process identifier
	* 3-byte counter"

	| processIdentifier counter |
	processIdentifier := Processor activeProcess basicIdentityHash.
	value := LargePositiveInteger new: 12.	
	"Equivalent to DateAnTime now asUnixTime, but without all the instantiation.
	(2177452800 is the offset in seconds between Squeak epoch and Unix epoch)
	Overall speedup of [OID new ] bench by 4X or so, so let's say it's worth it."
	counter := self class counterNext.
	value
		replaceFrom: 9 to: 12 with: Time totalSeconds - 2177452800 startingAt: 1;
		replaceFrom: 6 to: 8 with: self class machineIdentifier startingAt: 1;
		digitAt: 5 put: (processIdentifier bitAnd: 16rFF);
		digitAt: 4 put: ((processIdentifier bitShift: -8) bitAnd: 16rFF);
		digitAt: 3 put: (counter bitShift: -16);
		digitAt: 2 put:((counter bitShift: -8) bitAnd: 16rFF);
		digitAt: 1 put: (counter bitAnd:16rFF)
		
]

{ #category : #printing }
OID >> printOn: aStream [ 
	aStream 
		nextPutAll: 'OID';
		nextPut: $(;
		nextPutAll: self value printStringHex;
		nextPut: $)
]

{ #category : #private }
OID >> setValue: anInteger [ 
	value := anInteger
]

{ #category : #accessing }
OID >> timeStamp [
	"extract the upper 4 bytes from the object id which is the timestamp in seconds"
	^ value bitShift: -64
]

{ #category : #accessing }
OID >> value [
	^value
]

{ #category : #mongo }
OID >> writeBSONOn: aBSON [ 
	aBSON nextOIDPut: self
]
