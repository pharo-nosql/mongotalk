stop/continue
cleanupSockets

	(({ Socket. SocketStream } collect: #allInstances) collect: #size) traceCr.
	3 timesRepeat: [ Smalltalk garbageCollect ].
	(({ Socket. SocketStream } collect: #allInstances) collect: #size) traceCr.
