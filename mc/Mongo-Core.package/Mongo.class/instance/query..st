operations
query: aMongoQuery
	| results |
	results := OrderedCollection new.
	aMongoQuery doBlock isNil ifTrue: [
		aMongoQuery doBlock: [:each | results add: each]].
	(MongoCursor root: self query: aMongoQuery ) execute.
	(results isNotEmpty and: [ results first includesKey: '$err' ])
		ifTrue: [ ^ MongoQueryError signalFor: results first ].
	^ results