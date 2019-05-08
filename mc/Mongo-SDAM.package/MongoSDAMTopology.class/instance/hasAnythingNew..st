testing
hasAnythingNew: newServerDescription

	newServerDescription isSuccess ifFalse: [ ^false ].

	primaryUrlString = newServerDescription ismaster primaryUrlString ifFalse: [ ^ true ].

	^ false.