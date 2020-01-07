stop/continue
start
	self assert: replicaSet isNil.
	replicaSet := MongoTestReplicaSet new
		addMember: 1 port: self mongoUrlA port priority: 5.0;
		addMember: 2 port: self mongoUrlB port priority: 3.0;
		addMember: 3 port: self mongoUrlC port priority: 0.0;
		startAllAndInitiate;
		yourself.