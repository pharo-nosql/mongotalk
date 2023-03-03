"
A Mongo query.

See: https://docs.mongodb.com/v4.0/reference/mongodb-wire-protocol/
"
Class {
	#name : #MongoQuery,
	#superclass : #Object,
	#instVars : [
		'database',
		'where',
		'fields',
		'limit',
		'offset',
		'order',
		'chunkSize',
		'doBlock',
		'collection',
		'flags',
		'operation'
	],
	#category : #'Mongo-Core-Base'
}

{ #category : #accessing }
MongoQuery >> chunkSize [
	^chunkSize ifNil: [ chunkSize := self defaultChunkSize ]
]

{ #category : #accessing }
MongoQuery >> chunkSize: anInteger [

	^ chunkSize := anInteger
]

{ #category : #accessing }
MongoQuery >> collection [
	^collection
]

{ #category : #accessing }
MongoQuery >> collection: aMongoCollection [
	collection := aMongoCollection
]

{ #category : #accessing }
MongoQuery >> database [
	^ database
]

{ #category : #accessing }
MongoQuery >> database: aMongoDatabase [
	database := aMongoDatabase
]

{ #category : #default }
MongoQuery >> defaultChunkSize [
	^0
]

{ #category : #default }
MongoQuery >> defaultFields [
	^nil
]

{ #category : #default }
MongoQuery >> defaultLimit [
	^0
]

{ #category : #default }
MongoQuery >> defaultOffset [
	^0
]

{ #category : #default }
MongoQuery >> defaultWhere [
	^Dictionary new
]

{ #category : #accessing }
MongoQuery >> doBlock [
	^doBlock
]

{ #category : #accessing }
MongoQuery >> doBlock: aBlock [

	doBlock := aBlock
]

{ #category : #accessing }
MongoQuery >> fields [
	^ fields ifNil: [ fields := self defaultFields ]
]

{ #category : #accessing }
MongoQuery >> fields: aDictionary [
	fields := aDictionary
]

{ #category : #accessing }
MongoQuery >> flags [
	"Query operation flags. See QueryOperation class side."
	
	^flags ifNil: [ flags := 0 ]
]

{ #category : #accessing }
MongoQuery >> flags: flagsAsInteger [
	"Query operation flags. See QueryOperation class side."
	
	flags := flagsAsInteger
]

{ #category : #accessing }
MongoQuery >> from: anInteger to: anotherInteger [
	self skip: anInteger - 1.
	self limit: anotherInteger
]

{ #category : #accessing }
MongoQuery >> limit [
	^ limit ifNil: [ limit := self defaultLimit]
]

{ #category : #accessing }
MongoQuery >> limit: anInteger [
	limit := anInteger
]

{ #category : #accessing }
MongoQuery >> offset [
	^ offset ifNil: [ offset := self defaultOffset ].
]

{ #category : #accessing }
MongoQuery >> offset: anInteger [
	offset := anInteger
]

{ #category : #accessing }
MongoQuery >> operation [

	^ operation
]

{ #category : #accessing }
MongoQuery >> operation: operationClass [
	operation  := operationClass
]

{ #category : #accessing }
MongoQuery >> order [
	^ order
]

{ #category : #accessing }
MongoQuery >> order: anArrayOfAssociation [
	order := anArrayOfAssociation asDictionary.
]

{ #category : #'perform query' }
MongoQuery >> perform [
	^collection performQuery: self.
]

{ #category : #accessing }
MongoQuery >> qualifiedName [

	collection ifNil: [ ^ nil ].	
	^ database name, '.', collection name
]

{ #category : #accessing }
MongoQuery >> where [
	^ where ifNil: [ where := self defaultWhere]
]

{ #category : #accessing }
MongoQuery >> where: anObject [
	where := anObject asMongoQuery 
]
