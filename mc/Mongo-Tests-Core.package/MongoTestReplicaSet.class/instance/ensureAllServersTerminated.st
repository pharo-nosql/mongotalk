operations
ensureAllServersTerminated
	servers do: [ :each | each ensureTerminated ]