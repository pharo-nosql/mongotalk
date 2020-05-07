accessing
local
	^ local ifNil: [ local := self newWithLevel: 'local' ]