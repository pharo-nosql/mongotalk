stop/continue
cleanupSockets

	SocketStream allInstancesDo: #destroy.
	3 timesRepeat: [ Smalltalk garbageCollect ].
	(({ Socket. SocketStream } collect: #allInstances) collect: #size) traceCr.
