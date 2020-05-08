private
handleConnectionError: anError on: selectedMonitor
	"React (internally) to connection error and then pass the error to the external handler."
	
	selectedMonitor handleConnectionError: anError.
	anError pass