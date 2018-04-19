tests-as yet unclassified
testConcernForCommand
	| writeConcern formatted |

	writeConcern := MongoWriteConcern new.
	formatted := writeConcern concernForCommand.
	self assert: formatted isNil.

	writeConcern w: MongoWriteConcern majority.
	formatted := writeConcern concernForCommand.
	self assert: formatted keys equals: #('w').
	self assert: (formatted at: 'w') equals: 'majority'.

	writeConcern w: 3.
	writeConcern j: true.
	writeConcern wtimeout: 0.
	formatted := writeConcern concernForCommand.
	self assert: formatted keys sorted equals: #('j' 'w').
	self assert: (formatted at: 'w') equals: 3.
	self assert: (formatted at: 'j') equals: true.


	writeConcern wtimeout: 10.
	formatted := writeConcern concernForCommand.
	self assert: formatted keys sorted equals: #('j' 'w' 'wtimeout').
	self assert: (formatted at: 'w') equals: 3.
	self assert: (formatted at: 'j') equals: true.
	self assert: (formatted at: 'wtimeout') equals: 10.