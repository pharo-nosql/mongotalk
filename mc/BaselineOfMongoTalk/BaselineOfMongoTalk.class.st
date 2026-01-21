Class {
	#name : 'BaselineOfMongoTalk',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMongoTalk',
	#package : 'BaselineOfMongoTalk'
}

{ #category : 'baseline' }
BaselineOfMongoTalk >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [

			self libbson: spec.
			self libmongoc: spec.

			spec
				"Core and Client, without any test."
				package: 'Mongo-Pharo11';
				package: 'Mongo-BSON';
				package: 'Mongo-Queries';
				package: 'Mongo-Squeak' with: [ spec requires: #('Mongo-BSON') ];
				package: 'Mongo-Core' with: [ spec requires: #('Mongo-Squeak' 'Mongo-BSON') ];
				package: 'Mongo-DriverV5' with: [ spec requires: #('Mongo-Core') ];
				package: 'Mongo-DriverC' with: [ spec requires: #('Mongo-Core' 'LibBSON' 'LibMongoC') ];
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
				group: 'MongoC' with: #('Core' 'Mongo-DriverC');
				group: 'Tools' with: #('Mongo-Pharo-Tools');
				group: 'Tests' with: #('Core' 'Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries');
				"group: 'Tests + ReplicaSet Tests' with: #(Tests 'Mongo-Tests-ReplicaSet');"
				group: 'Client' with: #('default' 'Mongo-Client' 'Mongo-Client-Tests') ]
				"group: 'Client + ReplicaSet Tests' with: #('Client' 'Mongo-Client-ReplicaSet-Tests') ]".

	spec
		for: #(#'pharo10.x' #'pharo11.x' #'pharo12.x')
		do: [  spec package: 'Mongo-Client' with: [ spec requires: #('Mongo-Core') ] ].

	spec
		for: #(#'pharo11.x' #'pharo12.x' #'pharo13.x')
		do: [  
			self unifiedFFI: spec.
			spec 
				package: 'Mongo-DriverC' 
				with: [ spec requires: #('Mongo-Core' 'UnifiedFFI' 'LibBSON' 'LibMongoC') ] ].

	spec 
		for: #(#'pharo10.x' #'pharo11.x')
		do: [ spec package: 'Mongo-BSON' with: [ spec requires: #('Mongo-Pharo11') ] ]
]

{ #category : 'external projects' }
BaselineOfMongoTalk >> libbson: spec [

	spec baseline: 'LibBSON' with: [
		spec repository: 'github://pharo-cig/pharo-libbson:v1.0.1' ]
]

{ #category : 'external projects' }
BaselineOfMongoTalk >> libmongoc: spec [

	spec baseline: 'LibMongoC' with: [
		spec repository: 'github://pharo-cig/pharo-libmongoc:v2.0' ]
]

{ #category : 'accessing' }
BaselineOfMongoTalk >> project [
	
	| aProject |
	
	aProject := super project.
	aProject loadType: #atomic.
	^ aProject
]

{ #category : 'external projects' }
BaselineOfMongoTalk >> unifiedFFI: spec [
	
	spec
		baseline: 'UnifiedFFI'
		with: [ 
			spec 
				repository: 'github://pharo-cig/UnifiedFFI:v1.2';
				className: 'BaselineOfUnifiedFFIFull' ]
]
