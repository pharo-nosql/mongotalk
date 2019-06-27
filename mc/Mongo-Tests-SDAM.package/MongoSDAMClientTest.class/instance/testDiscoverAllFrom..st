tests - discovering
testDiscoverAllFrom: aCollectionOfZnUrls
	
	| expectedServerCount |
	client := MongoSDAMClient withUrls: aCollectionOfZnUrls.

	client start.

	"Impossible to know it already, but there is one (unknown) server."
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.

	"The client will only know C if it's among the initial urls"
	expectedServerCount :=
		(aCollectionOfZnUrls includes: MongoReplicationTestResources mongoUrlC)
			ifTrue: [ 3 ]
			ifFalse: [ 2 ].
	
	10 milliSeconds wait.
	self assert: client topology servers size equals: expectedServerCount.
