removing
removeAll: aCollection
	"Worry about atomicity?"

	aCollection do: [:each | self remove: each]