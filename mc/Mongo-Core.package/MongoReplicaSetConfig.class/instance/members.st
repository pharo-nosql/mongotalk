accessing
members
	^(self config at: 'members')
		collect: [ :each | MongoReplicaSetConfigMember with: each ]