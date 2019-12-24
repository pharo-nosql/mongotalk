enumerating
select: aDictionary limit: limit offset: offset order: orderDictionary flags: flags
	^ self query: [:query |
		query
			where: aDictionary;
			limit: limit; 
			offset: offset; 
			order: orderDictionary;
			flags: flags ]
	