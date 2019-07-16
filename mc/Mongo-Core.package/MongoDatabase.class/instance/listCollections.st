operations
listCollections
	"Answer the raw response of listCollections command.
	See more at https://docs.mongodb.com/manual/reference/command/listCollections/"

	^ self command: { #listCollections -> 1 } asDictionary