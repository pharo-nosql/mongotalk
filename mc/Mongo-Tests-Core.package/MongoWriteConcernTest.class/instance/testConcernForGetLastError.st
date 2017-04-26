tests-as yet unclassified
testConcernForGetLastError
	| writeConcern formatted |

	writeConcern := MongoWriteConcern new.
	formatted := writeConcern concernForGetLastError.
	self assert: formatted keys sorted equals: #('getLastError').
	self assert: (formatted at: 'getLastError') equals: 1.

	writeConcern w: MongoWriteConcern majority.
	formatted := writeConcern concernForGetLastError.
	self assert: formatted keys sorted equals: #('getLastError' 'w').
	self assert: (formatted at: 'getLastError') equals: 1.
	self assert: (formatted at: 'w') equals: 'majority'.

	writeConcern w: 3.
	writeConcern j: true.
	writeConcern wtimeout: 0.
	formatted := writeConcern concernForGetLastError.
	self assert: formatted keys sorted equals: #('getLastError' 'j' 'w').
	self assert: (formatted at: 'getLastError') equals: 1.
	self assert: (formatted at: 'w') equals: 3.
	self assert: (formatted at: 'j') equals: true.


	writeConcern wtimeout: 10.
	formatted := writeConcern concernForGetLastError.
	self assert: formatted keys sorted equals: #('getLastError' 'j' 'w' 'wtimeout').
	self assert: (formatted at: 'getLastError') equals: 1.
	self assert: (formatted at: 'w') equals: 3.
	self assert: (formatted at: 'j') equals: true.
	self assert: (formatted at: 'wtimeout') equals: 10.