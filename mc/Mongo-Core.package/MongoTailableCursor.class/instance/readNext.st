as yet unclassified
readNext
	| reply |
	reply := (ReplyOperation stream: root stream) read.
	reply do: query doBlock.
	^reply