creation
socketStreamHost: aString port: anInteger 
	| result |
	result := SocketStream openConnectionToHostNamed: aString port: anInteger.
	result binary.
	^result