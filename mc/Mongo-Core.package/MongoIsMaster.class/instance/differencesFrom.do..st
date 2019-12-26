accessing - diff
differencesFrom: anotherMongoIsMaster do: aBlockClosure
	"Evaluate a block closure on each of the differences found between self and another IsMaster response (potentially from a different server in a replica set)."

	self basicDifferencesFrom: anotherMongoIsMaster do: aBlockClosure.
	self isReplicaSet ifTrue: [
		self replicaSetDifferencesFrom: anotherMongoIsMaster do: aBlockClosure ].