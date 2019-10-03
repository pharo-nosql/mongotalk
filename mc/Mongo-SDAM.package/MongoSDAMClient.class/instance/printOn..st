printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	| numberOfStartedMonitors totalServers |
	super printOn: aStream.
	
	numberOfStartedMonitors := monitors count: #isStarted.
	totalServers := topology serversUrlStrings size.
	
	aStream
		nextPutAll: '(ON:';
		print: numberOfStartedMonitors;
		nextPutAll: ';OFF:';
		print: totalServers;
		nextPut: $).
