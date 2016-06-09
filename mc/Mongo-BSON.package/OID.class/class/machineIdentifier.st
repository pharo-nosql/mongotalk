accessing
machineIdentifier
	^ machineIdentifier ifNil: [ machineIdentifier := self newMachineIdentifier ]
