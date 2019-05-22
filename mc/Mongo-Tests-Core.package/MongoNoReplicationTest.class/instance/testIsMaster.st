tests
testIsMaster

	| response |
	response := mongo isMaster.
	
	"Common API is short."
	self deny: response isNil.
	self deny: response isReadOnly.
	self deny: response isReplicaSet.
	
	"Replica Set API that works, anyway."
	self deny: response hasPrimary.
	self deny: response isPrimary.
	self deny: response isSecondary.
