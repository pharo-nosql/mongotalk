testing
isStarted
	^ monitors allSatisfy: [ :each | each isStarted ]