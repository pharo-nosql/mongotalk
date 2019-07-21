convenience
waitMongoAt: aZnUrl satisfies: conditionBlock upTo: aDuration onCompletion: successBlock onTimeout: failBlock

	| mongo smallDuration end |
	smallDuration := 100 milliSeconds.
	end := DateAndTime now + aDuration.

	[	mongo := Mongo url: aZnUrl.
	[[	mongo openWithTimeout: aDuration.
		(conditionBlock value: mongo) ifTrue: [ ^ successBlock value ]]
			on: Error do: [ :e | e logCr ]] ensure: [ mongo closeIfOpen ].
		smallDuration wait.
	] doWhileFalse: [ DateAndTime now > end ].

	^ failBlock value