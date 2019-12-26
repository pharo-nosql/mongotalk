stepping
stepService
	"Check server and inform response"
	self checkOnce.

	"Update time"
	self stepDelay: client monitoringFrequency.
