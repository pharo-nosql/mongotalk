I represent read preference modes that are different than "primary". Such modes may have maxStaleness and tags parameters.

Extracted from documentation:

"The following are common use cases for using non-primary read preference modes:

    * Running systems operations that do not affect the front-end application.

    * Providing local reads for geographically distributed applications.
    If you have application servers in multiple data centers, you may consider having a geographically distributed replica set and using a non primary or nearest read preference. This allows the client to read from the lowest-latency members, rather than always reading from the primary.

    * Maintaining availability during a failover.
    Use primaryPreferred if you want an application to read from the primary under normal circumstances, but to allow stale reads from secondaries when the primary is unavailable. This provides a “read-only mode” for your application during a failover."

Source: https://docs.mongodb.com/v4.0/core/read-preference/