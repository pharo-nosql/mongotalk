resetting
newMachineIdentifier
	"Used to be an MD5 hash of local hostname, but that primitive always returns 'localhost' on at least Macs...
	Use a UUID instead, it will be different for the same machine after restarts, but the OID should never be used to identify a documents origin anyways."
	^ UUID new