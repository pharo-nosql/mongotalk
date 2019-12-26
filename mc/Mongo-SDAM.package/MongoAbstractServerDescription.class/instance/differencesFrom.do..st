accessing
differencesFrom: anotherMongoSDAMServerDescription do: aBlockClosure
	self class = anotherMongoSDAMServerDescription class ifFalse: [
		aBlockClosure
			cull: #class
			cull: anotherMongoSDAMServerDescription class -> self class ]