baseline
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ self grease: spec. self PBKDF2: spec. self osProcess: spec. self taskIt: spec.
			spec
				package: 'Mongo-BSON';
				package: 'Mongo-Squeak' with: [ spec requires: #('Grease' 'Mongo-BSON') ];
				package: 'Mongo-Core' with: [ spec requires: #('PBKDF2' 'Mongo-Squeak' 'Mongo-BSON') ];
				package: 'Mongo-SDAM' with: [ spec requires: #('TaskIt' 'Mongo-Core') ];
				package: 'Mongo-Queries';
				package: 'Mongo-Tests-BSON' with: [ spec requires: #('Mongo-BSON') ];
				package: 'Mongo-Tests-Core' with: [ spec requires: #('Mongo-Core' 'OSProcess') ];
				package: 'Mongo-Tests-SDAM' with: [ spec requires: #('Mongo-Tests-Core' 'Mongo-SDAM') ];
				package: 'Mongo-Tests-Queries' with: [ spec requires: #('Mongo-Queries') ];
				package: 'Mongo-Pharo-Tools' with: [ spec requires: #('Mongo-Core' 'Mongo-Queries') ].
			spec
				group: 'default' with: #('Core' 'Tools' 'Tests');
				group: 'Core' with: #('Mongo-Core' 'Mongo-Queries');
				group: 'Tools' with: #('Mongo-Pharo-Tools');
				group: 'Tests' with: #('Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries');
				group: 'SDAM' with: #('default' 'Mongo-SDAM' 'Mongo-Tests-SDAM') ]