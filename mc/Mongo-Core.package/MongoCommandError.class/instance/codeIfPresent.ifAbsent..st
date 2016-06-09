accessing
codeIfPresent: presentBlock ifAbsent: absentBlock
	^ reply 
		at: 'code' 
		ifPresent: [ :code | presentBlock cull: code ]
		ifAbsent: absentBlock