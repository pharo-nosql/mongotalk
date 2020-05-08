accessing
differencesFrom: anotherMongoServerDescription do: aBlockClosure

	"If there is a diff in super, stop here."
	super differencesFrom: anotherMongoServerDescription do: [:selector :diff |
		^ aBlockClosure cull: selector cull: diff ].

	"Then, check diff in isMaster response."
	self isMaster
		differencesFrom: anotherMongoServerDescription isMaster
		do: aBlockClosure
