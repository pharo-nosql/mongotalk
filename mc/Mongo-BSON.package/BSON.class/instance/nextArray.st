reading
nextArray
	| elements results index |
	elements := self nextDictionary.
	results := Array new: elements size.
	index := 1.
	elements associationsDo: [ :eachAssociation | 
		results at: (eachAssociation key asNumber +1) put: eachAssociation value.
		index := index + 1].
	^results