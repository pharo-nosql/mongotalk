writing
dataBytes 
	^dataBytes ifNil: [dataBytes := self computeDataBytes]