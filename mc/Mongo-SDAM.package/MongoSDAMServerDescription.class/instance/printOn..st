printing
printOn: aStream
	super printOn: aStream.

	aStream nextPutAll: ':'; cr.
	#(isSecondary staleness) do: [ :each |
		aStream
			tab;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each);
			cr ].
	
	
