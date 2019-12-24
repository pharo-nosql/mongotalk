I provide methods that are useful to  set up and manage the replica set test resources.  Follow my guide to prepare replication tests scenario. See my class-side methods.


	Scenario:
	---------
	
		mongo 'A':
			localhost:27031 -> priority 5.0 
				=> primary member in the replica set
		mongo 'B':
			localhost:27032 -> priority 3.0 
				=> secondary member in the replica set, except when A steps down
		mongo 'C':
			localhost:27033 -> priority 0.0
				=> secondary member in the replica set, can't be primary
