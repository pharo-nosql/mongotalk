running
prepareScenarioWhereAllExceptCStopped

	"Start client and wait it's available."
	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.

	"Then stop all but C, and finally wait until monitors realize."
	self stopAllExceptCAndWait.
