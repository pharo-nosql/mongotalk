accessing
socketTimeout: aDuration
	socketTimeout := aDuration.
	
	"New value will take effect on next accesses."
	self closeAll.