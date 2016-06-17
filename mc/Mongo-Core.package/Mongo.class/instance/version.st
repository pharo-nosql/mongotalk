accessing
version
	"Get the mongodb instance vrsion. The result is obtained via `buildInfo` command. 
	See more: https://docs.mongodb.com/manual/reference/command/buildInfo/"

	| buildInfo |
	buildInfo := self admin command: {'buildInfo' -> 1.0} asDictionary.
	
	^ buildInfo at: 'version'