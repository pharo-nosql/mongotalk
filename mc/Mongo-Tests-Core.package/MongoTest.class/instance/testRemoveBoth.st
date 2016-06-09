tests
testRemoveBoth
	"Unlike regular collections, MongCollection>>remove: is more like copyWithout:,
	removing all instances of the offending element."

	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	collection add: data.
	self assert: collection size = 2.
	collection remove: data.
	self assert: collection isEmpty