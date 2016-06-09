instance creation
collection: aString id: idInteger stream: aStream cursorId: cursorInteger returnCount: countInteger
	^(self collection: aString
		id: idInteger
		stream: aStream)
			setCursorId: cursorInteger
			returnCount: countInteger 