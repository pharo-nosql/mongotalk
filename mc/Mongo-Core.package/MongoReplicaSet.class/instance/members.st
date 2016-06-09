accessing
members
	^(self config at: 'members')
		collect: [ :each | MongoReplicaSetMember with: each ]