codec
writeAll: aCollection 
	| writer |
	writer := self writer.
	aCollection do: [:each | writer nextDictionaryPut: each].
	^writer contents