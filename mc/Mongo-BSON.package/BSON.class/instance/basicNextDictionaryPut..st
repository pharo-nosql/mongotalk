writing
basicNextDictionaryPut: aCollection
	| start end |
	start := stream position.
	stream nextInt32Put: 0.	"Just to make space"
	aCollection do: [:each | each writeBSONOn: self].
	stream null.
	end := stream position.
	stream position: start.
	stream nextInt32Put: end - start.
	stream position: end