resetting
newCounter
	"A new 3-byte counter, initialized to a random value, as per the spec."
	"Abuse the fact that we use a type4 UUID as machine identifier, and copy some of the random unused bits from that."
	^(LargePositiveInteger new: 3) 
		replaceFrom: 1 to:3 with: self machineIdentifier startingAt: 4; 
		normalize.