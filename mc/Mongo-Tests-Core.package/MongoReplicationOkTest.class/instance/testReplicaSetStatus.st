tests
testReplicaSetStatus
	| replicaSetStatus |

	"See _manual_set_up_ to set up the testing mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	replicaSetStatus := mongo replicaSetStatus.

	self assert: replicaSetStatus name isString.
	self deny: replicaSetStatus members isEmpty.
	self assert: replicaSetStatus members anyOne host isString.
	self assert: replicaSetStatus members anyOne port isNumber.
	self deny: replicaSetStatus primaryMember isNil.
