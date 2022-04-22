Extension { #name : #Object }

{ #category : #'*Mongo-Queries' }
Object >> mqAccept: aVisitor [
	^ aVisitor visitObject: self
]
