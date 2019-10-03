stop/continue
pkill: matchingString with: aSignalNumber
	| command result |
	command := 'pkill -{1} -f "{2}"' format: { aSignalNumber. matchingString }.
	result := LibC resultOfCommand: command.
	^ result