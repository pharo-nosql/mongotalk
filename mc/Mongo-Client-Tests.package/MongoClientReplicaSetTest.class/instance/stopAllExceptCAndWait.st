running
stopAllExceptCAndWait
	"Then stop all but C (the that cannot be primary), and wait until monitors realize."

	self stopAllExceptC.
	self waitMonitorsHeartbeatAndTimeout.