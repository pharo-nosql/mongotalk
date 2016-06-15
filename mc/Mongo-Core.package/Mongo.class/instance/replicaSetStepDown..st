operations
replicaSetStepDown: aDuration
	"Forces the primary of the replica set to become a secondary, triggering an election for primary. The command steps down the primary for a specified number of seconds; during this period, the stepdown member is ineligible from becoming primary.

	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetStepDown/"

	"This command produces a connection close. We'll re-open. Same behavior as in mongo shell... too smart?"
	[ self admin command: {('replSetStepDown' -> aDuration asSeconds)} asDictionary ]
		on: ConnectionClosed
		do: [ self isOpen ifFalse: [ self open ] ]
