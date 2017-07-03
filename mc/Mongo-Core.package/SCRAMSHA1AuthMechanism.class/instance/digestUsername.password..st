private
digestUsername: username password: password
	^(MD5 hashMessage: username , ':mongo:' , password) hex.