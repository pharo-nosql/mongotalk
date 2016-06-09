tests
testReplicaSet
	"Follow comment in my superclass to set up the expected test mongo replica set."

	| replicaSet |
	self skip. "<-- Remove this skip if proper external set up"

	replicaSet := mongo replicaSet.

	self assert: replicaSet name isString.
	self deny: replicaSet members isEmpty.
	self assert: replicaSet members anyOne name isString.
	self assert: replicaSet members anyOne priority isNumber.