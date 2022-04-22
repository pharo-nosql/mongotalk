Extension { #name : #BlockClosure }

{ #category : #'*Mongo-Queries' }
BlockClosure >> asMongoQuery [ 
	^ MQQueryBuilder queryFor: self
]
