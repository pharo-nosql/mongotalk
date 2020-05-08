stop/continue
stop
	"Stop the testing scenario. See description in class comment."

	<example>
	replicaSet ifNotNil: [
		replicaSet ensureAllServersTerminated.
		replicaSet := nil ]