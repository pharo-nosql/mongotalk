operations
query: aMongoQuery
	| results |
	results := OrderedCollection new.
	aMongoQuery doBlock isNil ifTrue: [
		aMongoQuery doBlock: [:each | results add: each]].
	(MongoCursor root: self query: aMongoQuery ) execute.
	(results isNotEmpty and: [ (results first includesKey: '$err') or: [ (results first includesKey: 'errmsg') and: [ (results first includesKey: 'code') and: [ results first includesKey: 'ok' ] ] ] ])
		ifTrue: [ ^ MongoQueryError signalFor: results first ].
	^ results