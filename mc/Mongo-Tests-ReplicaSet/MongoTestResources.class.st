Class {
	#name : #MongoTestResources,
	#superclass : #Object,
	#category : 'Mongo-Tests-ReplicaSet'
}

{ #category : #accessing }
MongoTestResources class >> mongoUrlOffline [
	"Important: We assume there is no localhost:27029 mongodb"
	
	^ 'localhost:27029' asMongoUrl
]
