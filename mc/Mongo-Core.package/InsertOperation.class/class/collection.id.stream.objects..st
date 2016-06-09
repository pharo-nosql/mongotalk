instance creation
collection: aString id: idInteger stream: aStream objects: aCollection
	^(self collection: aString
		id: idInteger
		stream: aStream)
			setObjects: aCollection 