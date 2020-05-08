accessing
majority
	^ majority ifNil: [ majority := self newWithLevel: 'majority' ]