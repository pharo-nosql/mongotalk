I represent the response of a "isMaster" command, defined by documentation in the following way:

isMaster returns a document that describes the role of the mongod instance. If the optional field saslSupportedMechs is specified, the command also returns an array of SASL mechanisms used to create the specified user’s credentials.

If the instance is a member of a replica set, then isMaster returns a subset of the replica set configuration and status including whether or not the instance is the primary of the replica set.

When sent to a mongod instance that is not a member of a replica set, isMaster returns a subset of this information.

MongoDB drivers and clients use isMaster to determine the state of the replica set members and to discover additional members of a replica set.


Read more at: https://docs.mongodb.com/v4.0/reference/command/isMaster/