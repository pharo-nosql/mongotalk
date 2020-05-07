printing
printStatusOn: aStream

	| numberOfStartedMonitors totalServers |
	numberOfStartedMonitors := monitors count: #isStarted.
	totalServers := topology numberOfServers.
	
	aStream
		nextPutAll: 'ON:';
		print: numberOfStartedMonitors;
		nextPutAll: ';OFF:';
		print: totalServers - numberOfStartedMonitors.
