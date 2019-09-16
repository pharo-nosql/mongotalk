accessing - diff
replicaSetDifferencesFrom: anotherMongoIsMaster do: aBlockClosure
	"Evaluate a block closure on each of the replica set differences between self and another IsMaster response (potentially from a different server in a replica set)."

	#(replicaSetHosts isSecondary hasPrimary primaryUrlString) do: [ :each | 
		| mine theirs |
		mine := self perform: each.
		theirs := anotherMongoIsMaster perform: each.
		mine = theirs ifFalse: [ aBlockClosure cull: each cull: theirs -> mine ] ]