operations
validate
	| reply |
	reply := database command: (Dictionary new at: 'validate' put: name; yourself).
	^CollectionValidation on: reply