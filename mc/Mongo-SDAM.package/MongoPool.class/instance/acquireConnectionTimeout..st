accessing
acquireConnectionTimeout: aDuration
	"The maximum amount of time a caller to #mongoDo: (or #next) can wait for a Mongo connection to become available. The SDAM spec names it 'waitQueueTimeoutMS'.
	
	Following the SDAM spec, a value of nil means no timeout.
	
	Read more at: https://github.com/mongodb/specifications/blob/03aed6c58dcd6afd81980876be2042afc45d06d3/source/connection-monitoring-and-pooling/connection-monitoring-and-pooling.rst#w1dcrm950sbn"

	acquireConnectionTimeout := aDuration.

	"New value will take effect on next accesses."
	self resetAll