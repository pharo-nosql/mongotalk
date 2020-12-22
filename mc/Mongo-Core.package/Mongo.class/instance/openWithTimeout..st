operations
openWithTimeout: aDuration
	| addr |
	"Waits the specified number of seconds to open the connection."
	addr := NetNameResolver addressForName: host timeout: 20.
	stream := self openConnectionToHost: addr port: port timeout: aDuration asSeconds.
	authCache := nil