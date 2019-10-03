stop/continue
pkillMongodAt: aZnUrl with: aSignalNumber
	"Signal any mongod process at the specified port, with the specified signal number."
	
	"Fragile: We just assume the process has this full name."
	^ self
		pkill: 'mongod --port ' , aZnUrl port asString
		with: aSignalNumber