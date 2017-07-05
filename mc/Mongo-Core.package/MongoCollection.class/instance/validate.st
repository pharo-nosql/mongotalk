operations
validate
	| reply |
	reply := database command: (OrderedIdentityDictionary new at: #validate put: name; yourself).
	^CollectionValidation on: reply