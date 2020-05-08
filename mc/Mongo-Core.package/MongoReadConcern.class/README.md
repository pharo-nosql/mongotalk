I represent a MongoDB read concern. 

The readConcern option allows you to control the consistency and isolation properties of the data read from replica sets and replica set shards.

Through the effective use of write concerns and read concerns, you can adjust the level of consistency and availability guarantees as appropriate, such as waiting for stronger consistency guarantees, or loosening consistency requirements to provide higher availability.

Possible read concern levels are:
	* 'local'
	* 'available'
	* 'majority'
	* 'linearizable
	* 'snapshot'

See more: https://docs.mongodb.com/v4.0/reference/read-concern/


