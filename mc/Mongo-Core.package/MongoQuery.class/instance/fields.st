accessing
fields
	^ fields ifNil: [ fields := self defaultFields ]