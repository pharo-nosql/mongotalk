accessing
mongoDo: aBlockClosure
	| mongo result |
	mongo := self availableMongo.
	result := [ aBlockClosure value: mongo ]
		ensure: [ self returnConnection: mongo ].
	^ result
	