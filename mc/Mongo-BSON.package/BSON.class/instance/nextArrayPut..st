writing
nextArrayPut: anArray
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