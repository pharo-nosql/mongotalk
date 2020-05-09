accessing
differencesFrom: anotherMongoServerDescription do: aBlockClosure
	self class = anotherMongoServerDescription class ifFalse: [
		aBlockClosure
			cull: #class
			cull: anotherMongoServerDescription class -> self class ]