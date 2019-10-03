accessing
mongoDo: aBlockClosure
	"Evaluate the BlockClosure with a Mongo instance. See #next.
	
	For error handling, the specification states that the client MUST clear its connection pool for the server: if one socket is bad, it is likely that all are.

	Source: https://github.com/mongodb/specifications/blob/573b1f58a129056d651781ad99317b6c656e050e/source/server-discovery-and-monitoring/server-discovery-and-monitoring-summary.rst#id9
	"

	[ | mongo |
		mongo := self next.
		^ [ aBlockClosure value: mongo ] ensure: [ self return: mongo ] ]
			on: NetworkError
			do: [ :e | self close. e signal ]
