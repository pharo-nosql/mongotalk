accessing
start

	process ifNotNil: [ self error: 'already started' ].

	process := [ [
		client refreshTopologyWith: self checkOnce.
		client steadyStateFrequency wait] repeat ] fork.