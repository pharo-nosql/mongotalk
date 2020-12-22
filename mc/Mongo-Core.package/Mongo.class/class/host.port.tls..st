instance creation
host: aString port: anInteger tls: aBoolean
	"Return a new instance on the given server and port"

	^ self new setHost: aString port: anInteger tls: aBoolean