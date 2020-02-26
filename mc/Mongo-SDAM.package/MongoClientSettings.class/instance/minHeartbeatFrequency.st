accessing - monitor
minHeartbeatFrequency
	"If a client frequently rechecks a server, it MUST wait at least minHeartbeatFrequencyMS milliseconds since the previous check ended, to avoid pointless effort. This value MUST be 500 ms, and it MUST NOT be configurable. 

Source: https://github.com/mongodb/specifications/blob/573b1f58a129056d651781ad99317b6c656e050e/source/server-discovery-and-monitoring/server-discovery-and-monitoring.rst#minheartbeatfrequencyms"

	^ 500 milliSeconds