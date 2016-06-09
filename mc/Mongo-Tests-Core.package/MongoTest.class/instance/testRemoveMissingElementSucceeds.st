tests
testRemoveMissingElementSucceeds
	"Unlike Collection, MongoCollection succeeds if you try to remove a missing element.
	Hence there is no need for remove:ifAbsent:."
	collection add: ((Dictionary new)
				at: 'key1' put: 'value1';
				yourself).
	self assert: collection size = 1.
	collection remove: ((Dictionary new)
				at: 'key2' put: 'value2';
				yourself).
	self assert: collection size = 1 "No exception"