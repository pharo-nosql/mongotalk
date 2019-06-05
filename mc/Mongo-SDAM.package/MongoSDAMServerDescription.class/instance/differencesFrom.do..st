accessing
differencesFrom: anotherMongoSDAMServerDescription do: aBlockClosure

	"If there is a diff in super, stop here."
	super differencesFrom: anotherMongoSDAMServerDescription do: [:selector :diff |
		^ aBlockClosure cull: selector cull: diff ].

	"Then, check diff in isMaster response."
	self isMaster
		differencesFrom: anotherMongoSDAMServerDescription isMaster
		do: aBlockClosure
