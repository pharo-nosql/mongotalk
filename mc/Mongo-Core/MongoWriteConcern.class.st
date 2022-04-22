"
I represent a MongoDb write concern. 

Write concern describes the level of acknowledgement requested from MongoDB for write operations to a standalone mongod or to replica sets or to sharded clusters. In sharded clusters, mongos instances will pass the write concern on to the shards.

See documentation in my #accessing protocol.
See more in the web: https://docs.mongodb.com/manual/reference/write-concern/
"
Class {
	#name : #MongoWriteConcern,
	#superclass : #Object,
	#instVars : [
		'w',
		'j',
		'wtimeout'
	],
	#category : 'Mongo-Core-Utilities'
}

{ #category : #accessing }
MongoWriteConcern class >> majority [
	^'majority'
]

{ #category : #converting }
MongoWriteConcern >> asKeysAndValuesInto: aDictionary [
	self j ifNotNil: [:value | aDictionary at: 'j' put: value ].
	self w ifNotNil: [:value | aDictionary at: 'w' put: value ].
	self wtimeout ifNotNil: [:value | aDictionary at: 'wtimeout' put: value ]
]

{ #category : #converting }
MongoWriteConcern >> concernForCommand [
	| dict |
	dict := Dictionary new.
	self asKeysAndValuesInto: dict.
	^dict isEmpty
		ifTrue: [ nil ]
		ifFalse: [ dict ]
]

{ #category : #accessing }
MongoWriteConcern >> j [
	"Answer the 'j' option of this mongodb write concern. See #j:"

	^ j
]

{ #category : #accessing }
MongoWriteConcern >> j: aBoolean [
	"Set the 'j' option of this mongodb write concern. The j option requests acknowledgement from MongoDB that the write operation has been written to the journal.
	
	See more: https://docs.mongodb.com/manual/reference/write-concern/#j-option
	"
	
	j := aBoolean
]

{ #category : #accessing }
MongoWriteConcern >> w [
	"Answer the 'w' option of this mongodb write concern. See #w:"
	
	^ w
]

{ #category : #accessing }
MongoWriteConcern >> w: anObject [
	"Set the 'w' option of this mongodb write concern. The w option requests acknowledgement that the write operation has propagated to a specified number of mongod instances or to mongod instances with specified tags.

	Possible arguments:
	- 'majority': Requests acknowledgment that write operations have propagated to the majority of voting nodes, including the primary, and have been written to the on-disk journal for these nodes.
	- <natural number>: Requests acknowledgement that the write operation has propagated to the specified number of mongod instances.
	- <collection of tags>: Requests acknowledgement that the write operations have propagated to a replica set member with the specified tag.
	
	See more: https://docs.mongodb.com/manual/reference/write-concern/#w-option
	"

	w := anObject
]

{ #category : #accessing }
MongoWriteConcern >> wtimeout [
	"Answer the 'wtimeout' option of this mongodb write concern. See #wtimeout:"
	
	^ wtimeout = 0
		ifTrue: [ nil ]
		ifFalse: [ wtimeout ]
]

{ #category : #accessing }
MongoWriteConcern >> wtimeout: aTimeOutInMilliseconds [
	"Set the 'wtimeout' option of this mongodb write concern. This option specifies a time limit, in milliseconds, for the write concern. wtimeout is only applicable for w values greater than 1.
	
	See more: https://docs.mongodb.com/manual/reference/write-concern/#wtimeout
"
	
	wtimeout := aTimeOutInMilliseconds
]
