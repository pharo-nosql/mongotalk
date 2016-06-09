writing
nextSizedStringPut: aString
	| encoded |
	encoded := self encode: aString.
	self nextInt32Put: encoded size + 1.	"For terminating null"
	self nextEncodedStringPut: encoded