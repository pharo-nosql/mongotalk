private
newOsProcess
	^ OSProcess thisOSProcess
        forkJob: self class mongodPathString
        arguments: self mongodArguments
        environment: nil
        descriptors: nil