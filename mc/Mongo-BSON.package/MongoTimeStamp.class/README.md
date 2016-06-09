BSON has a special timestamp type for internal MongoDB use and is not associated with the regular Date type. Timestamp values are a 64 bit value where:

- the first 32 bits are a time_t value (seconds since the Unix epoch)
- the second 32 bits are an incrementing ordinal for operations within a given second.

See more on: https://docs.mongodb.org/manual/reference/bson-types/#timestamps

    Instance Variables
	value:		<an integer of 64 bits>
