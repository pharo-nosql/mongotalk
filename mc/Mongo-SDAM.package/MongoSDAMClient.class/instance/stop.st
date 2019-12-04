API
stop
	| futures |
	futures := monitors values
		select: [ :each | each isRunning ]
		thenCollect: [ :each | each stop ].
	(futures reduce: [ :f1 :f2 | f1 zip: f2 ])
		waitForCompletion: 40 seconds