accessing
timeStamp
	"extract the upper 4 bytes from the object id which is the timestamp in seconds"
	^ value bitShift: -64