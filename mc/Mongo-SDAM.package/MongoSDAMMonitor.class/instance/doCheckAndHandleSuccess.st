private
doCheckAndHandleSuccess

	| response roundtripDuration |
	roundtripDuration := [ response := mongo isMaster ] timeToRun.
	self handleSuccessfulIsMaster: response for: roundtripDuration.