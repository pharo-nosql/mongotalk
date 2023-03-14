"
I have some very basic WriteConcern format tests
"
Class {
	#name : #MongoWriteConcernTest,
	#superclass : #TestCase,
	#category : #'Mongo-Tests-Core-Tests'
}

{ #category : #'tests-as yet unclassified' }
MongoWriteConcernTest >> testAsConcernForCommand [
	| writeConcern formatted |

	writeConcern := MongoWriteConcern new.
	formatted := writeConcern asConcernForCommand.
	self assert: formatted isNil.

	writeConcern w: MongoWriteConcern majority.
	formatted := writeConcern asConcernForCommand.
	self assert: formatted keys equals: #('w').
	self assert: (formatted at: 'w') equals: 'majority'.

	writeConcern w: 3.
	writeConcern j: true.
	writeConcern wtimeout: 0.
	formatted := writeConcern asConcernForCommand.
	self assert: formatted keys sorted equals: #('j' 'w').
	self assert: (formatted at: 'w') equals: 3.
	self assert: (formatted at: 'j') equals: true.


	writeConcern wtimeout: 10.
	formatted := writeConcern asConcernForCommand.
	self assert: formatted keys sorted equals: #('j' 'w' 'wtimeout').
	self assert: (formatted at: 'w') equals: 3.
	self assert: (formatted at: 'j') equals: true.
	self assert: (formatted at: 'wtimeout') equals: 10
]
