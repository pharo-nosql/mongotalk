operations
ensureAllServersStarted
	"Ensure that each server is individually started (#initiateReplicaSet must be sent by separate)."

	servers
		do: [ :each | each ensureStarted ];
		do: [ :each | each waitIsWrittable ].
