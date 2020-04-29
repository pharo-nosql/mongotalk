stop/continue
start
	self assert: replicaSet isNil.
	replicaSet := MongoTestReplicaSet new
		addMember: 'A' port: self mongoUrlA port priority: 5.0;
		addMember: 'B' port: self mongoUrlB port priority: 3.0;
		addMember: 'C' port: self mongoUrlC port priority: 0.0;
		startAllAndInitiate;
		yourself.