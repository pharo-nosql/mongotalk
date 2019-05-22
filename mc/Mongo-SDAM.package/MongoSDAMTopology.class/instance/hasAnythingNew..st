testing
hasAnythingNew: newServerDescription

	newServerDescription isSuccess ifFalse: [ ^false ].

	self hasPrimary ~= newServerDescription isMaster hasPrimary ifTrue: [ ^true ].
	(self hasPrimary and: [ self primaryUrlString ~= newServerDescription isMaster primaryUrlString ])
		ifTrue: [ ^true ].

	^ false