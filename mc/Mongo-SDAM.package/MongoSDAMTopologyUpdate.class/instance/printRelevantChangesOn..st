printing
printRelevantChangesOn: aStream
	aStream nextPutAll: '{ '.
	newTopology
		differencesFrom: oldTopology
		do: [ :selector :diff | 
			aStream
				nextPutAll: selector;
				nextPutAll: ': ';
				print: diff;
				nextPutAll: '. ' ].
	aStream nextPutAll: '}'.
