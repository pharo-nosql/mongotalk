private-communicating
cursorQuery: aQuery
	| id |
	id := self nextRequestID.
	(aQuery operation 
		id: id
		stream: stream
		query: aQuery)
			flags: aQuery flags;
			write.
	^id