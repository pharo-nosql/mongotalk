accessing
differencesFrom: anotherMongoTopology do: aBlockClosure

	#(type primaryUrlString secondaryUrlStrings) do: [ :each | 
		| mine theirs |
		mine := self perform: each.
		theirs := anotherMongoTopology perform: each.
		mine = theirs ifFalse: [ aBlockClosure cull: each cull: theirs -> mine ] ]