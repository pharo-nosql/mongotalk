private
setCollection: aString id: idInteger stream: aStream
	id := idInteger.
	writer := LittleEndianStream on: aStream.
	collectionBytes := writer encode: aString
	