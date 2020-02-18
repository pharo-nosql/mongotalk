accessing
maxConnections: aQuantity
	maxConnections := aQuantity.

	"New value will take effect on next accesses."
	self closeAll.