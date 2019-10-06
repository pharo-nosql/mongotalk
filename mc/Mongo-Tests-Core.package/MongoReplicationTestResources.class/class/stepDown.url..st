stop/continue
stepDown: aDuration url: aZnUrl
	
	| mongo |
	mongo := Mongo url: aZnUrl.
	mongo open.
	mongo replicaSetStepDown: aDuration.
	mongo closeIfOpen