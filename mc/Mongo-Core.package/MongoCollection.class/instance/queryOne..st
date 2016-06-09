queries
queryOne: aBlock
	| query |
	query := self newQuery.
	aBlock value: query.
	^database queryOne: query