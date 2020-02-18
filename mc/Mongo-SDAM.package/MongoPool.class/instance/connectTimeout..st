accessing
connectTimeout: aDuration
	connectTimeout := aDuration.
	
	"New value will take effect on next accesses."
	self closeAll.