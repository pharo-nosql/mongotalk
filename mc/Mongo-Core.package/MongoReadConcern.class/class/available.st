accessing
available
	^ available ifNil: [ available := self newWithLevel: 'available' ]