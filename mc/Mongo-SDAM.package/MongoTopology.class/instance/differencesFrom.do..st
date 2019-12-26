accessing
differencesFrom: anotherMongoSDAMTopology do: aBlockClosure

	#(type primaryUrlString secondaryUrlStrings) do: [ :each | 
		| mine theirs |
		mine := self perform: each.
		theirs := anotherMongoSDAMTopology perform: each.
		mine = theirs ifFalse: [ aBlockClosure cull: each cull: theirs -> mine ] ]