testing
hasAnythingNew: newServerDescription

	newServerDescription isSuccess ifFalse: [ ^false ].

	self hasPrimary ~= newServerDescription ismaster hasPrimary ifTrue: [ ^true ].
	(self hasPrimary and: [ self primaryUrlString ~= newServerDescription ismaster primaryUrlString ])
		ifTrue: [ ^true ].

	^ false