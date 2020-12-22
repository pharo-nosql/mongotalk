operations
socketStreamClass
	^ self tls
		ifTrue: [ ZdcSecureSocketStream ]
		ifFalse: [ SocketStream ]