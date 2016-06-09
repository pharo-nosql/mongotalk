enumerating
select: aDictionary limit: limit offset: offset
	^ self query: [:query |
		query
			where: aDictionary;
			limit: limit; 
			offset: offset ]
	