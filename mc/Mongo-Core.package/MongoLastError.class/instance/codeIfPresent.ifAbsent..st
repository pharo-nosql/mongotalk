accessing
codeIfPresent: presentBlock ifAbsent: absentBlock
	"Error code. See: https://docs.mongodb.com/manual/reference/command/getLastError/#getLastError.code"

	^ reply 
		at: 'code' 
		ifPresent: [ :code | presentBlock cull: code ]
		ifAbsent: absentBlock
