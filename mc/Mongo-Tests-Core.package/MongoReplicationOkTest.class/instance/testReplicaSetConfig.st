tests
testReplicaSetConfig
	| replicaSet |

	"Follow my class comment to set up the expected mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	replicaSet := mongo replicaSetConfig.

	self assert: replicaSet name isString.
	self deny: replicaSet members isEmpty.
	self assert: replicaSet members anyOne name isString.
	self assert: replicaSet members anyOne priority isNumber.