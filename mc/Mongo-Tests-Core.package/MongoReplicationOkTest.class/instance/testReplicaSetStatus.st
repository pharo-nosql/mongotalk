tests
testReplicaSetStatus
	"Follow comment in my superclass to set up the expected test mongo replica set."

	| replicaSetStatus |
	self skip. "<-- Remove this skip if proper external set up"

	replicaSetStatus := mongo replicaSetStatus.

	self assert: replicaSetStatus name isString.
	self deny: replicaSetStatus members isEmpty.
	self assert: replicaSetStatus members anyOne host isString.
	self assert: replicaSetStatus members anyOne port isNumber.
	self deny: replicaSetStatus primaryMember isNil.
