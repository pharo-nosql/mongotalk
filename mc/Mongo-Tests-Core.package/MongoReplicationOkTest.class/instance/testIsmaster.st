tests
testIsMaster

	| response |
	response := mongo isMaster.
	
	"Common API is short."
	self deny: response isNil.
	self deny: response isReadOnly.
	self assert: response isReplicaSet.
	
	"Replica Set specific API."
	self assert: response hasPrimary.
	self assert: response isPrimary.
	self deny: response isSecondary.
	self assert: response urlString equals: mongo host, ':', mongo port asString.
	self assert: response primaryUrlString equals: response urlString.
	self assert: response replicaSetHosts equals: #('localhost:27031' 'localhost:27032').
	self assert: response lastWriteDateAndTime notNil.