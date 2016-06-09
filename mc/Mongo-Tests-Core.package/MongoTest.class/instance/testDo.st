tests
testDo
	| count |
	collection add: (Dictionary new at: 'key' put: 'value'; yourself).
	collection add: (Dictionary new at: 'key' put: 'value'; yourself).
	count := 0.
	collection do: [:each | self assert: (each at: 'key') = 'value'. count := count + 1].
	self assert: count equals: 2