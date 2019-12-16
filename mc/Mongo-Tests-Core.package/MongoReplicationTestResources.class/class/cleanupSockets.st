stop/continue
cleanupSockets

	(({ Socket. SocketStream } collect: #allInstances) collect: #size) traceCr.
	SocketStream allInstancesDo: #destroy.
	3 timesRepeat: [ Smalltalk garbageCollect ].
	(({ Socket. SocketStream } collect: #allInstances) collect: #size) traceCr.
