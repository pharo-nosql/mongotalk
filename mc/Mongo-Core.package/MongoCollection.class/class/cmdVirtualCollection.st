convenience
cmdVirtualCollection
	"Answer an object that represents '$cmd', a special virtual collection that
	exposes MongoDB’s database commands.
	
	See: https://docs.mongodb.com/v4.2/reference/glossary/#term-cmd
	"

	^ self database: nil name: '$cmd'
