writing
nextStringPut: aString 
	| encoded |
"	encoder := UTF8StreamEncoder new.
	aString do: [:each | encoder nextPut: each on: stream]."
	encoded := self encode: aString.
	self nextEncodedStringPut: encoded 