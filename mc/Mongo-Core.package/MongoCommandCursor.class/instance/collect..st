enumerating
collect: aBlockClosure 
	^ Array streamContents: [ :stream |
		self do: [ :each | stream nextPut: (aBlockClosure value: each) ] ]
