enumerating
do: aBlock
	returnCount timesRepeat: [aBlock value: (BSON read: stream)]