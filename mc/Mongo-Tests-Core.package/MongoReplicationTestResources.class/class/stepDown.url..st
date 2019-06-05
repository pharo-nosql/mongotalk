accessing
stepDown: aDuration url: aZnUrl
	
	| mongo |
	mongo := Mongo 
		host: aZnUrl host 
		port: aZnUrl port.

	mongo open.

	[ mongo replicaSetStepDown: aDuration ]
		on: Error 
		do: [:e | "Ignore" ].

	mongo isOpen ifTrue: [ mongo close ]