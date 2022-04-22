Class {
	#name : #MongoMockTests,
	#superclass : #TestCase,
	#instVars : [
		'mongo'
	],
	#category : 'Mongo-Tests-Core-Tests'
}

{ #category : #setup }
MongoMockTests >> setUp [
	super setUp.
	mongo := MongoMock new
]

{ #category : #tests }
MongoMockTests >> testAuthenticationSucceeds [
	self assert: (mongo authenticateUsername: 'foo' password: 'bar' database: 'baz')
]

{ #category : #tests }
MongoMockTests >> testDatabaseAuthenticationDifferentUser [
	| database |
	database := mongo databaseNamed: 'foo'.
	database username: 'foo' password: 'bar'.
	database username: 'bar' password: 'foo'.
	self assert: mongo authCalls = 2.
	self assert: mongo authCache keys size = 1
	
]

{ #category : #tests }
MongoMockTests >> testDatabaseAuthenticationSameUser [
	| database1 database2 |
	database1 := mongo databaseNamed: 'foo'.
	database1 username: 'foo' password: 'bar'.
	database2 := mongo databaseNamed: 'foo'.
	database2 username: 'foo' password: 'bar'.
	self assert: mongo authCalls = 1.
	self assert: mongo authCache keys size = 1
	
]

{ #category : #tests }
MongoMockTests >> testDatabaseAuthenticationSameUserTwice [
	| database |
	database := mongo databaseNamed: 'foo'.
	database username: 'foo' password: 'bar'.
	database username: 'foo' password: 'bar'.
	self assert: mongo authCalls = 1
	
]

{ #category : #tests }
MongoMockTests >> testTwoDatabasesAuthenticationSameUser [
	| database1 database2 |
	database1 := mongo databaseNamed: 'foo1'.
	database1 username: 'foo' password: 'bar'.
	database2 := mongo databaseNamed: 'foo2'.
	database2 username: 'foo' password: 'bar'.
	self assert: mongo authCalls = 2.
	self assert: mongo authCache keys size = 2
	
]
