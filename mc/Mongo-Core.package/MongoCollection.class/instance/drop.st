operations
drop
	database
		command:
			(OrderedIdentityDictionary new
				at: #drop put: name;
				yourself)	"check return value"