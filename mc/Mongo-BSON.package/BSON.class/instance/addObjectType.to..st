private
addObjectType: anInteger to: aDictionary
	aDictionary 
		at: self nextKey
		put: (self nextValueForType: anInteger)