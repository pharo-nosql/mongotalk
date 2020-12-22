operations
openConnectionToHost: aString port: anInteger timeout: timeoutInSeconds
	| result |
	result := self socketStreamClass
		openConnectionToHost: aString
		port: anInteger
		timeout: timeoutInSeconds.
	self tls
		ifTrue: [ result sslSession serverName: self host. result connect ]
	ifFalse: [ result socket setOption: 'TCP_NODELAY' value: 1 ].
	result binary.
	^ result