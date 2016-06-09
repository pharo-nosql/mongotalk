accessing
port
	| colonPosition |
	colonPosition := self name indexOf: $:.

	^(self name allButFirst: colonPosition) asInteger