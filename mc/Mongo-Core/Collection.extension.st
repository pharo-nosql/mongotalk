Extension { #name : #Collection }

{ #category : #'*mongo-core' }
Collection >> asMongoQuery [
	^ self asDictionary
]
