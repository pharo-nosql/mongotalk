initialization
settingsDictionary: aDictionary
	"Set a dictionary of settings for the replSetInitiate command.

	See: https://docs.mongodb.com/v4.0/reference/replica-configuration/#settings.
	
	An example dictionary:
		{
			'electionTimeoutMillis' -> 5000.
			'heartbeatTimeoutSecs' -> 5.
		} asOrderedDictionary
	"

	settingsDictionary := aDictionary