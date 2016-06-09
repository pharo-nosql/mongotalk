accessing
members
	^(status at: 'members')
		collect: [ :each | MongoReplicaSetStatusMember with: each ]