printing
printStatusOn: aStream

	| numberOfStartedMonitors totalServers |
	numberOfStartedMonitors := monitors count: #isStarted.
	totalServers := topology serversUrlStrings size.
	
	aStream
		nextPutAll: 'ON:';
		print: numberOfStartedMonitors;
		nextPutAll: ';OFF:';
		print: totalServers - numberOfStartedMonitors.
