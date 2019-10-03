stop/continue
pkill: matchingString with: aSignalNumber
	| command |
	command := 'pkill -{1} -f "{2}"' format: { aSignalNumber. matchingString }.
	LibC system: command.
