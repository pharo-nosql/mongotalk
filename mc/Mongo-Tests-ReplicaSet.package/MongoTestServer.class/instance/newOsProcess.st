private
newOsProcess
	^ OSSUnixSubprocess new
		command: self class mongodPathString;
		arguments: self mongodArguments;
		redirectStdout;
		redirectStderr;
		terminateOnShutdown;
		yourself