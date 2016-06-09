accessing
chunkSize
	^chunkSize ifNil: [ chunkSize := self defaultChunkSize ]