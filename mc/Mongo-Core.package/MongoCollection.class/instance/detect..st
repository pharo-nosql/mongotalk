enumerating
detect: aDictionary
	^self queryOne: [ :query |
		query where: aDictionary ]