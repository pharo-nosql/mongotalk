Class {
	#name : #MongoPoolTest,
	#superclass : #MongoTest,
	#instVars : [
		'pool'
	],
	#category : 'Mongo-Client-Tests'
}

{ #category : #testing }
MongoPoolTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #running }
MongoPoolTest >> setUp [
	| settings |
	settings :=
		MongoClientSettings new 
			maxConnections: 5;
			connectTimeout: 10 seconds;
			socketTimeout: 5 seconds;
			yourself.

	pool := MongoPool
		url: 'localhost' asMongoUrl
		settings: settings.
	
	root := pool next.

	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.

]

{ #category : #tests }
MongoPoolTest >> smallLapse [
	^ 9 milliSeconds
]

{ #category : #running }
MongoPoolTest >> tearDown [
	database ifNotNil: [ database collections do: #drop ].
	pool return: root.
	pool resetAll.
]

{ #category : #tests }
MongoPoolTest >> testNormallyCacheMaxConnections [
	| usedMongoConnections |
	pool settings maxConnections: 5.

	usedMongoConnections := SharedQueue new.
	pool settings maxConnections + 1 timesRepeat: [ [
		pool mongoDo: [ :mongo |
			usedMongoConnections nextPut: mongo.
			self smallLapse wait ] ] fork ].

	"Ensure each forked process obtain a connection."
	(self smallLapse * 2)	 wait.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool settings maxConnections + 1.
	
	"The pool keeps #maxConnection open connections and
	closes the exceeding one when returned."
	self
		assert: (usedMongoConnections contents count: [:each | each isOpen ])
		equals: pool settings maxConnections.

]

{ #category : #tests }
MongoPoolTest >> testPoolConnectionsAreClosedAfterNetworkError [
	| usedMongoConnections |
	pool settings maxConnections: 5.

	usedMongoConnections := SharedQueue new.
	pool settings maxConnections timesRepeat: [ [
		pool mongoDo: [ :mongo |
			usedMongoConnections nextPut: mongo.
			self smallLapse wait ] ] fork ].

	"Ensure each forked process obtain a connection."
	(self smallLapse * 2)	 wait.

	"Produce a (fake) network error. The pool should react by
	closing all connections but also must pass it for externally hnadling it."
	self should: [
		pool mongoDo: [ :mongo |
			usedMongoConnections nextPut: mongo.
			NetworkError signal ]] raise: NetworkError.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool settings maxConnections.
	
	"The pool closed all connections."
	self assert: (usedMongoConnections contents noneSatisfy: [:each | each isOpen ]).

]

{ #category : #tests }
MongoPoolTest >> testPoolConnectionsArentClosedAfterOtherErrors [
	| usedMongoConnections |
	pool settings maxConnections: 5.

	usedMongoConnections := SharedQueue new.

	"Produce an error on each forked process. 
	The pool should do nothing on cached Mongo connections but
	pass the error for external handlers."
	pool settings maxConnections timesRepeat: [ [
		self
			should: [
				pool mongoDo: [ :mongo |
					usedMongoConnections nextPut: mongo.
					self smallLapse wait.
					1/0 ] ]
			raise: ZeroDivide ] fork ].

	"Wait enough for each forked process to terminate."
	(self smallLapse * 2)	 wait.
	
	self
		assert: usedMongoConnections contents asIdentitySet size
		equals: pool settings maxConnections.
	
	"The pool kept all connections open in cache."
	self assert: (usedMongoConnections contents allSatisfy: [ :each | each isOpen ]).

]
