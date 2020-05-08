accessing
snapshot
	^ snapshot ifNil: [ snapshot := self newWithLevel: 'snapshot' ]