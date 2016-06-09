operations
drop
	| command |
	command := Dictionary new.
	command at: 'drop' put: name.
	database command: command "check return value"