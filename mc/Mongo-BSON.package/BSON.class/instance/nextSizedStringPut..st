writing
nextSizedStringPut: aString
	| encoded |
	encoded := stream encode: aString.
	stream nextInt32Put: encoded size + 1.	"For terminating null"
	stream nextBytesPut: encoded asByteArray.
	stream null