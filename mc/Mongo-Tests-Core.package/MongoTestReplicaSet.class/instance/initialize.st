initialization
initialize
	super initialize.
	
	replicaSetName := 'rs-test'.
	memberDescriptions := OrderedCollection new.
	servers := OrderedCollection new.
	settingsDictionary := Dictionary new.