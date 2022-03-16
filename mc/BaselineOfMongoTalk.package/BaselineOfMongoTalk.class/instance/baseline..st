baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ self grease: spec. self PBKDF2: spec. self osSubprocess: spec. self taskIt: spec.
			spec

				"Core and Client, without any test."
				package: 'Mongo-BSON';
				package: 'Mongo-Queries';
				package: 'Mongo-Squeak' with: [ spec requires: #('Grease' 'Mongo-BSON') ];
				package: 'Mongo-Core' with: [ spec requires: #('PBKDF2' 'Mongo-Squeak' 'Mongo-BSON') ];
				package: 'Mongo-Pharo-Tools' with: [ spec requires: #('Mongo-Core' 'Mongo-Queries') ];
				package: 'Mongo-Client' with: [ spec requires: #('Mongo-Core') ];

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
				group: 'Core' with: #('Mongo-Core' 'Mongo-Queries');
				group: 'Tools' with: #('Mongo-Pharo-Tools');
				group: 'Tests' with: #('Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries');
				group: 'Tests + ReplicaSet Tests' with: #(Tests 'Mongo-Tests-ReplicaSet');
				group: 'Client' with: #('default' 'Mongo-Client' 'Mongo-Client-Tests');
				group: 'Client + ReplicaSet Tests' with: #('Client' 'Mongo-Client-ReplicaSet-Tests') ].
	
	spec
		for: #(#'pharo7.x' #'pharo8.x' )
		do: [  
			spec 
				package: 'Mongo-Client' with: [ spec requires: #('TaskIt') ].
			spec
				group: 'default' with: #('Tools') ].
