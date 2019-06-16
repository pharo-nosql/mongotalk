running
tearDown
	database drop.
	pool returnConnection: root.
	pool flush.