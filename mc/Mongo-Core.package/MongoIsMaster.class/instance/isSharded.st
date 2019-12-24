accessing
isSharded
	"Answer whether it's a sharded instance.

	See more at: 
	https://docs.mongodb.com/manual/reference/command/isMaster/#sharded-instances"
	
	^ response includesKey: 'msg'