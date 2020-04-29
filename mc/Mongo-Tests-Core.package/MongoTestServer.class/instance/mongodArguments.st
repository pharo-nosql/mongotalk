private
mongodArguments
	^ Array streamContents: [ :stream |
		stream
			nextPut: '--port'; nextPut: self portString;
			nextPut: '--dbpath'; nextPut: self directoryString;
			nextPut: '--bind_ip 127.0.0.1'.
		self useSyslog ifTrue: [ 
			stream nextPut: '--syslog' ].
		self hasReplicaSetName ifTrue: [ 
			stream nextPut: '--replSet'; nextPut: self replicaSetName ]
		]