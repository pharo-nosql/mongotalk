Class {
	#name : #MongoClientDiscoveringTest,
	#superclass : #MongoClientReplicaSetTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #tests }
MongoClientDiscoveringTest >> testDiscoverAllFrom: aCollectionOfZnUrls [
	
	client := MongoClient withUrls: aCollectionOfZnUrls.
	client start.

	"Doesn't know more than one (unknown) server."
	self deny: client topology servers anyOne isSuccess.
	self assert: client topology servers size equals: 1.

	"Assert it discovered all servers."
	100 milliSeconds wait.
	self
		assert: (client topology servers allSatisfy: [ :each | each isSuccess ]).
	self
		assert: client topology servers size
		equals: MongoReplicationTestResources allMongoUrls size.

]

{ #category : #tests }
MongoClientDiscoveringTest >> testDiscoverFromHidden [
	
	self testDiscoverAllFrom: { MongoReplicationTestResources mongoUrlC }

]

{ #category : #tests }
MongoClientDiscoveringTest >> testDiscoverFromPrimary [
	
	self testDiscoverAllFrom: { MongoReplicationTestResources mongoUrlA }

]

{ #category : #tests }
MongoClientDiscoveringTest >> testDiscoverFromSecondary [
	
	self testDiscoverAllFrom: { MongoReplicationTestResources mongoUrlB }

]
