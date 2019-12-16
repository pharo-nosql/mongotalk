operations
closeWithTimeout: aDuration
	"First, try to close the connection gracefully. If the close attempt fails or times out, abort the connection. In either case, destroy the socket."

	stream close: aDuration asSeconds