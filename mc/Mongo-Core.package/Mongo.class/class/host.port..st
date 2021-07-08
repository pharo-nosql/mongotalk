instance creation
host: aString port: anInteger
	"Return a new instance on the given server and port"

	^ self host: aString port: anInteger tls: false