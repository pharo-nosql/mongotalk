queries
query: aBlock
	| query |
	query := self newQuery.
	aBlock value: query.
	^self performQuery: query