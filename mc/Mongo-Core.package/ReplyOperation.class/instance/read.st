reading
read
	| formatter size opCode responseFlag |
	formatter := LittleEndianStream on: stream.
	size := formatter nextInt32.
	id := formatter nextInt32.
	responseTo := formatter nextInt32.
	opCode := formatter nextInt32.	"should be 1"
	responseFlag := formatter nextInt32.	"should be 0"
	cursorId := formatter nextInt64.
	startingFrom := formatter nextInt32.
	returnCount := formatter nextInt32	"Element count"