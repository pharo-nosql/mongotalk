accessing
host
	| colonPosition |
	colonPosition := self name indexOf: $:.

	^self name first: colonPosition-1