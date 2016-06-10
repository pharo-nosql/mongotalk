tests
testReplicaSetStatus
	| replicaSetStatus |

	"Follow my class comment to set up the expected mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	replicaSetStatus := mongo replicaSetStatus.

	self assert: replicaSetStatus name isString.
	self deny: replicaSetStatus members isEmpty.
	self assert: replicaSetStatus members anyOne host isString.
	self assert: replicaSetStatus members anyOne port isNumber.
	self deny: replicaSetStatus primaryMember isNil.
