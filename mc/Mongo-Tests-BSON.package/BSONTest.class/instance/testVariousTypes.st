tests
testVariousTypes
	"2 raisedTo: 31 2147483648"
	"2 raisedTo: 63 9223372036854775808"
	| values |
	values := #('v' ('v') #v nil true false 1.0d 1 -1 -2 2147483647 2147483648 -2147483648 -2147483649 9223372036854775807 -9223372036854775808).
	values do: [:each | self encodeAndDecode: each]