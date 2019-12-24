accessing
isMaster
	"A boolean value that reports when this node is writable. If true, then this instance is a primary in a replica set, or a mongos instance, or a standalone mongod.

    This field will be false if the instance is a secondary member of a replica set or if the member is an arbiter of a replica set.

Source: https://docs.mongodb.com/manual/reference/command/isMaster/#isMaster.ismaster"

	^ response at: 'ismaster'