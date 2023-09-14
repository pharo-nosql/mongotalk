Class {
	#name : #BaselineOfMongoTalk,
	#superclass : #BaselineOf,
	#category : #BaselineOfMongoTalk
}

{ #category : #baseline }
BaselineOfMongoTalk >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [

			spec
				"Core and Client, without any test."
				package: 'Mongo-Pharo11';
				package: 'Mongo-BSON';
				package: 'Mongo-Queries';
				package: 'Mongo-Squeak' with: [ spec requires: #('Mongo-BSON') ];
				package: 'Mongo-Core' with: [ spec requires: #('Mongo-Squeak' 'Mongo-BSON') ];
				package: 'Mongo-DriverV5' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-DriverLegacy' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-Client' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-Pharo-Tools' with: [ spec requires: #('Mongo-Core' 'Mongo-Queries') ];
 				"Tests that are unrelated to Replica Set."
				package: 'Mongo-Tests-Queries' with: [ spec requires: #('Mongo-Queries') ];
				package: 'Mongo-Tests-BSON' with: [ spec requires: #('Mongo-BSON') ];
				package: 'Mongo-Tests-Core' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-Client-Tests' with: [ spec requires: #('Mongo-Tests-Core' 'Mongo-Client') ].
				"Tests for Replica Set."
				"package: 'Mongo-Tests-ReplicaSet' with: [ 
					spec requires: #('Mongo-Core' 'OSSubprocess') ];
				package: 'Mongo-Client-ReplicaSet-Tests' with: [
					spec requires: #('Mongo-Tests-ReplicaSet' 'Mongo-Client-Tests') ]."

			spec
				group: 'default' with: #('Core' 'Tests');
				group: 'Core' with: #('Mongo-Core' 'Mongo-Queries' 'Mongo-DriverV5');
				group: 'Tools' with: #('Mongo-Pharo-Tools');
				group: 'Tests' with: #('Core' 'Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries');
				"group: 'Tests + ReplicaSet Tests' with: #(Tests 'Mongo-Tests-ReplicaSet');"
				group: 'Client' with: #('default' 'Mongo-Client' 'Mongo-Client-Tests') ].
				"group: 'Client + ReplicaSet Tests' with: #('Client' 'Mongo-Client-ReplicaSet-Tests') ]".

	spec
		for: #(#'pharo10.x' #'pharo11.x' #'pharo12.x')
		do: [  spec package: 'Mongo-Client' with: [ spec requires: #('Mongo-Core') ] ].

	spec 
		for: #(#'pharo10.x' #'pharo11.x')
		do: [ spec package: 'Mongo-BSON' with: [ spec requires: #('Mongo-Pharo11') ] ]
]

{ #category : #'external projects' }
BaselineOfMongoTalk >> taskIt: spec [
	spec baseline: 'TaskIt' with: [
		spec
			repository: 'github://pharo-contributions/taskit:v1.1.1';
			loads: #(core) ]

]
