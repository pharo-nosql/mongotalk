enumerating
do: aBlock
	^ self query: [ :query |
		query doBlock: aBlock ]