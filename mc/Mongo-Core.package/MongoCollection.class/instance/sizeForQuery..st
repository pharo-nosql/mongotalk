private-operations
sizeForQuery: aDictionary
	| reply |
	reply := database command: ((OrderedIdentityDictionary new)
						at: #count put: name;
						at: #query put: aDictionary;
						at: #fields put: Dictionary new;
						yourself).
	^(reply at: 'n') asInteger	"Why in the world is it a double?"