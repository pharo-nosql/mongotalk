enumerating
select: aDictionary limit: limit offset: offset order: orderDictionary
	^ self query: [:query |
		query
			where: aDictionary;
			limit: limit; 
			offset: offset; 
			order: orderDictionary ]
	