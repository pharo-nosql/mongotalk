tests
testReplicaSetConfig
	| replicaSet |
	replicaSet := mongo replicaSetConfig.

	self assert: replicaSet name isString.
	self deny: replicaSet members isEmpty.
	self assert: replicaSet members anyOne name isString.
	self assert: replicaSet members anyOne priority isNumber.