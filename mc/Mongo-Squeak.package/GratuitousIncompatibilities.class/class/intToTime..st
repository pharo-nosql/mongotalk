converting
intToTime: anInteger 
	| sinceJavaEpoch |
	sinceJavaEpoch := Duration milliseconds: anInteger.
	^self epoch + sinceJavaEpoch