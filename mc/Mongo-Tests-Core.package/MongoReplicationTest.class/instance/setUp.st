running
setUp
	super setUp.
	
	isMongoAvailable :=
		[ mongo := self newMongo. mongo open. true ] 
			on: NetworkError 
			do: [ 	false ].