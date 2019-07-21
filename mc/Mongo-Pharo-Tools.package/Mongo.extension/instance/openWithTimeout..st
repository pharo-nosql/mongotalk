*Mongo-Pharo-Tools
openWithTimeout: aDuration
	| addr |
	"Waits the specified number of seconds to open the connection."
	addr := NetNameResolver addressForName: host timeout: 20.
	stream := SocketStream openConnectionToHost: addr port: port timeout: aDuration asSeconds.
	stream socket setOption: 'TCP_NODELAY' value: 1.
	stream binary.
	authCache := nil