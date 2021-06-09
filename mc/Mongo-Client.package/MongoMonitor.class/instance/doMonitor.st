private
doMonitor
	"This is the code executed repeated times by the fork while the monitor is started."

	"Check server and inform response"
	self checkOnce.

	"Sleep some time"
	client monitoringFrequency wait.