private
doMonitor
	"This is the code executed repeated times by the fork while the monitor is started."

	"Check server and inform response"
	latestServerDescription := self checkOnce.
	client refreshTopologyWith: latestServerDescription.

	"Sleep some time"
	client monitoringFrequency wait.
