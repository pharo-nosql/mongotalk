start/stop
runOsProcess
	osProcess
		runAndWaitPollingEvery: (Delay forMilliseconds: 250)
		doing: [ :aProcess :outStream :errStream |  
			Transcript
				<< outStream upToEnd;
				<< errStream upToEnd.
		]
		onExitDo: [ :aProcess :outStream :errStream |
			Transcript
				<< outStream upToEnd;
				<< errStream upToEnd;
				<< '>>>> ';
				<< aProcess exitStatusInterpreter.
			aProcess closeAndCleanStreams.
		]
