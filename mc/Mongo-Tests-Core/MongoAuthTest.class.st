Class {
	#name : #MongoAuthTest,
	#superclass : #TestCase,
	#instVars : [
		'root',
		'database'
	],
	#category : 'Mongo-Tests-Core-Tests'
}

{ #category : #running }
MongoAuthTest >> setUp [
	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
]

{ #category : #running }
MongoAuthTest >> tearDown [
	root close
]

{ #category : #tests }
MongoAuthTest >> testDefaultAuthMechanism [

	self assert: Mongo defaultAuthMechanismClass equals: SCRAMSHA1AuthMechanism.
	self assert: root authMechanism class equals: SCRAMSHA1AuthMechanism.

]

{ #category : #tests }
MongoAuthTest >> testSCRAMSHA1AuthMechanism [
	"ToDo: this test requires manual configuration. 
	=> Run in command-line:
	mongo test --eval 'db.createUser({ ""user"": ""pharounittest"", ""pwd"": ""test"", roles: [] });'
	"
	root authMechanism: (SCRAMSHA1AuthMechanism root: root).

	self assert: (root authenticateUsername: 'pharounittest' password: 'test' database: database).
	self assert: (root authenticateUsername: 'pharounittest' password: 'invalid' database: database) not
]
