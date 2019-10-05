convenience
waitMongoAt: aZnUrl satisfies: conditionBlock upTo: aDuration onCompletion: successBlock onTimeout: failBlock

	| mongo retryingDelay end timeout |
	retryingDelay := 250 milliSeconds.
	timeout := 1 second.
	end := DateAndTime now + aDuration.

	[	mongo := Mongo url: aZnUrl.
		[[	mongo openWithTimeout: timeout.
			mongo socketTimeout: timeout.
			(conditionBlock value: mongo) ifTrue: [ ^ successBlock value ]]
				on: Error do: [ :e | Transcript << '.' ]]
					ensure: [ mongo closeIfOpen ].
		retryingDelay wait.
	] doWhileFalse: [ DateAndTime now > end ].

	^ failBlock value