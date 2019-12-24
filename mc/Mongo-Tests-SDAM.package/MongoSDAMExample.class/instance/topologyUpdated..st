private
topologyUpdated: ann
	Transcript
		show: 'topology - ';
		show: client topology type; space;
		show: client topology primaryUrlString; space;
		show: client topology secondaryUrlStrings.
	client isMonitoringSteadyState ifFalse: [ Transcript show: ' - CRISIS STATE' ].
	Transcript cr.
