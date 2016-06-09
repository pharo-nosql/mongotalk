building
buildQueryFor: aBlock
	^ self newGenerator visit: (aBlock value: self newQuery)