Class {
	#name : #BaselineOfMongoTalk,
	#superclass : #BaselineOf,
	#category : #BaselineOfMongoTalk
}

{ #category : #'external projects' }
BaselineOfMongoTalk >> PBKDF2: spec [
	spec
		baseline: 'Cryptography' with: [ 
			spec 
				repository: 'github://pharo-contributions/Cryptography:0.5/source' ];
			
		project: 'PBKDF2' copyFrom: 'Cryptography' with: [ 
				 spec loads: 'PBKDF2'  ]
]

{ #category : #baseline }
BaselineOfMongoTalk >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			
			self PBKDF2: spec. 
			self osSubprocess: spec.

			spec
				"Core and Client, without any test."
				package: 'Mongo-BSON';
				package: 'Mongo-Queries';
				package: 'Mongo-Squeak' with: [ spec requires: #('Mongo-BSON') ];
				package: 'Mongo-Core' with: [ spec requires: #('PBKDF2' 'Mongo-Squeak' 'Mongo-BSON') ];
				package: 'Mongo-DriverV5' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-DriverLegacy' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-Client' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-Pharo-Tools' with: [ spec requires: #('Mongo-Core' 'Mongo-Queries') ];
 				"Tests that are unrelated to Replica Set."
				package: 'Mongo-Tests-Queries' with: [ spec requires: #('Mongo-Queries') ];
				package: 'Mongo-Tests-BSON' with: [ spec requires: #('Mongo-BSON') ];
				package: 'Mongo-Tests-Core' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-Client-Tests' with: [ spec requires: #('Mongo-Tests-Core' 'Mongo-Client') ];
				"Tests for Replica Set."
				package: 'Mongo-Tests-ReplicaSet' with: [ spec requires: #('Mongo-Core' 'OSSubprocess') ];
				package: 'Mongo-Client-ReplicaSet-Tests' with: [
					spec requires: #('Mongo-Tests-ReplicaSet' 'Mongo-Client-Tests') ].

			spec
				group: 'default' with: #('Core' 'Tests');
				group: 'Core' with: #('Mongo-Core' 'Mongo-Queries' 'Mongo-DriverV5');
				group: 'Tools' with: #('Mongo-Pharo-Tools');
				group: 'Tests' with: #('Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries');
				group: 'Tests + ReplicaSet Tests' with: #(Tests 'Mongo-Tests-ReplicaSet');
				group: 'Client' with: #('default' 'Mongo-Client' 'Mongo-Client-Tests');
				group: 'Client + ReplicaSet Tests' with: #('Client' 'Mongo-Client-ReplicaSet-Tests') ].
	spec
		for: #(#'pharo7.x' #'pharo8.x' )
		do: [ 
			self taskIt: spec.
			spec 
				package: 'Mongo-Client' with: [ spec requires: #('TaskIt') ].
			spec
				group: 'default' with: #('Tools') ].
	spec
		for: #(#'pharo9.x' #'pharo10.x' #'pharo11.x' #'pharo12.x')
		do: [  spec package: 'Mongo-Client' with: [ spec requires: #('Mongo-Core') ] ].

]

{ #category : #'external projects' }
BaselineOfMongoTalk >> grease: spec [ 
	spec
		baseline: 'Grease' with: [ 
			spec 
				repository: 'github://SeasideSt/Grease:v1.5.x/repository' ]

]

{ #category : #'external projects' }
BaselineOfMongoTalk >> osSubprocess: spec [
	spec
		baseline: 'OSSubprocess'
		with: [ spec repository: 'github://pharo-contributions/OSSubprocess:v1.3.0/repository' ]
]

{ #category : #'external projects' }
BaselineOfMongoTalk >> taskIt: spec [
	spec baseline: 'TaskIt' with: [
		spec
			repository: 'github://pharo-contributions/taskit:v1.1.1';
			loads: #(core) ]

]
