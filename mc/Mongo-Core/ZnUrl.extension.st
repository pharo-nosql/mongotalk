Extension { #name : #ZnUrl }

{ #category : #'*Mongo-Core' }
ZnUrl >> asMongoUrl [
	self assert: (self scheme = #mongodb).
	^self
]

{ #category : #'*Mongo-Core' }
ZnUrl >> asMongoUrlString [
	^ self host , ':' , self port asString
]
