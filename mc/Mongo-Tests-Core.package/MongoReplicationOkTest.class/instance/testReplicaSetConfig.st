tests
testReplicaSetConfig
	| replicaSet |

	"See _manual_set_up_ to set up the testing mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	replicaSet := mongo replicaSetConfig.

	self assert: replicaSet name isString.
	self deny: replicaSet members isEmpty.
	self assert: replicaSet members anyOne name isString.
	self assert: replicaSet members anyOne priority isNumber.