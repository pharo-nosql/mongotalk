printing
printShortDescriptionOn: aStream
	aStream nextPutAll: urlString.
	self isSuccess ifFalse: [ aStream nextPutAll: ' FAILED' ].