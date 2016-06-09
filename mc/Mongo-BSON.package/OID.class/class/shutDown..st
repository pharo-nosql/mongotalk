startup-shutdown
shutDown: quitting
	"reset counter and machine identifier on image save. We want at least calculate a new
	machine identifier if the image started somewhere else"
	self reset