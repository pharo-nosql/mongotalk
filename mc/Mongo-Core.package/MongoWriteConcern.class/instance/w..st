accessing
w: anObject
	"Set the 'w' option of this mongodb write concern. The w option requests acknowledgement that the write operation has propagated to a specified number of mongod instances or to mongod instances with specified tags.

	Possible arguments:
	- 'majority': Requests acknowledgment that write operations have propagated to the majority of voting nodes, including the primary, and have been written to the on-disk journal for these nodes.
	- <natural number>: Requests acknowledgement that the write operation has propagated to the specified number of mongod instances.
	- <collection of tags>: Requests acknowledgement that the write operations have propagated to a replica set member with the specified tag.
	
	See more: https://docs.mongodb.com/manual/reference/write-concern/#w-option
	"

	w := anObject