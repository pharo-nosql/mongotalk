Class {
	#name : #MongoUrlTest,
	#superclass : #TestCase,
	#category : 'Mongo-Tests-Core-Tests'
}

{ #category : #tests }
MongoUrlTest >> testDefaultPortUrl [
	| url |
	url := 'db.myserver' asMongoUrl.
	self assert: url scheme equals: 'mongodb'.
	self assert: url host equals: 'db.myserver'.
	self assert: url port equals: 27017.
]

{ #category : #tests }
MongoUrlTest >> testFullUrl [
	| url |
	url := 'db.myserver:8888' asMongoUrl.
	self assert: url scheme equals: 'mongodb'.
	self assert: url host equals: 'db.myserver'.
	self assert: url port equals: 8888.
]
