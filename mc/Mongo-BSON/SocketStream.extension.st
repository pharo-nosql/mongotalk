Extension { #name : #SocketStream }

{ #category : #'*mongo-bson-extensions' }
SocketStream >> position: aNumber [
	aNumber > lastRead 
		ifTrue: [ self skip: lastRead - aNumber ].
	lastRead := aNumber
]
