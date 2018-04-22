accessing
wtimeout: aTimeOutInMilliseconds
	"Set the 'wtimeout' option of this mongodb write concern. This option specifies a time limit, in milliseconds, for the write concern. wtimeout is only applicable for w values greater than 1.
	
	See more: https://docs.mongodb.com/manual/reference/write-concern/#wtimeout
"
	
	wtimeout := aTimeOutInMilliseconds