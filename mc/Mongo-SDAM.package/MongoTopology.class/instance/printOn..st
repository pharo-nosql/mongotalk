printing
printOn: aStream
	super printOn: aStream.
	
	aStream nextPutAll: ': '; cr.
	#(type primaryUrlString secondaryUrlStrings) do: [ :each |
		aStream
			tab;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each);
			cr ].
	
	
