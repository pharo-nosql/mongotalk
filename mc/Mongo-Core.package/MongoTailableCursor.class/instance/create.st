as yet unclassified
create
	| op reply |
	query chunkSize: 0.
	op := QueryOperation
		id: root nextRequestID
		stream: root stream
		query: query.
	op
		flags: ((QueryOperation flagTailableCursor | QueryOperation flagAwaitData));
		write.
	reply := (ReplyOperation stream: root stream) read.
	cursorId := reply cursorId.
	reply do: query doBlock.