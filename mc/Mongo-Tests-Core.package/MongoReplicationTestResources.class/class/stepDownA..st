accessing
stepDownA: aDuration
	
	| mongo |
	mongo := Mongo 
		host: self mongoUrlA host 
		port: self mongoUrlA port.

	mongo open.

	[ mongo replicaSetStepDown: aDuration ]
		on: Error 
		do: [:e | "Ignore" ].

	mongo isOpen ifTrue: [ mongo close ]