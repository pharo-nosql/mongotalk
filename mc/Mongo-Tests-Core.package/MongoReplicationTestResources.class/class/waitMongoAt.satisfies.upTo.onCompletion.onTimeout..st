as yet unclassified
waitMongoAt: aZnUrl satisfies: conditionBlock upTo: aDuration onCompletion: successBlock onTimeout: failBlock

	| mongo smallDuration end |
	smallDuration := 50 milliSeconds min: aDuration.
	end := DateAndTime now + aDuration.

	[	mongo := Mongo url: aZnUrl.
	[	mongo open.
		(conditionBlock value: mongo) 
			ifTrue: [ ^ successBlock value ] ] 
			on: Error do: [ :e | e logCr. mongo close ].
		smallDuration wait.
	] doWhileFalse: [ DateAndTime now > end ].

	^ failBlock value