private
mongodArguments
	^ Array streamContents: [ :stream |
		stream
			nextPut: '--port'; nextPut: self portString;
			nextPut: '--dbpath'; nextPut: self directoryString.
		self useSyslog ifTrue: [ 
			stream nextPut: '--syslog' ].
		self hasReplicaSetName ifTrue: [ 
			stream nextPut: '--replSet'; nextPut: self replicaSetName ]
		]