accessing
linearizable
	^ linearizable ifNil: [ linearizable := self newWithLevel: 'linearizable' ]