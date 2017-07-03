accessing
root: root
	|mech|
	mech := self new root: root.
	self authAgainstAdmin ifTrue: [ mech  forceDatabase: root admin].
	^ mech
		