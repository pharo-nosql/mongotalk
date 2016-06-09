*mongo-bson-extensions
position: aNumber
	aNumber > lastRead 
		ifTrue: [ self skip: lastRead - aNumber ].
	lastRead := aNumber