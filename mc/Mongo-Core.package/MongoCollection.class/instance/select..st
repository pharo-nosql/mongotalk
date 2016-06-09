enumerating
select: aDictionary
	^self query: [ :query |
		query where: aDictionary ]