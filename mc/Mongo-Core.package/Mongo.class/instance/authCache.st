accessing
authCache
	^ authCache ifNil: [ 
		authCache := Dictionary new ]