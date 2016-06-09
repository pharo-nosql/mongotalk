tests
testReplicaSet
	| replicaSet |

	"Follow my class comment to set up the expected mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	replicaSet := mongo replicaSet.

	self assert: replicaSet name isString.
	self deny: replicaSet members isEmpty.
	self assert: replicaSet members anyOne name isString.
	self assert: replicaSet members anyOne priority isNumber.