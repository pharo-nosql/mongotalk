printing
printRelevantChangesOn: aStream
	aStream nextPutAll: '{ '.
	newServerDescription
		differencesFrom: oldServerDescription
		do: [ :selector :diff | 
			aStream
				nextPutAll: selector;
				nextPutAll: ': ';
				print: diff;
				nextPutAll: '. ' ].
	aStream nextPutAll: '}'.
