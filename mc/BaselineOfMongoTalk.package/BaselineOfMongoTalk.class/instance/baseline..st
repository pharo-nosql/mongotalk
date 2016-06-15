baseline
baseline: spec
	<baseline>

	spec for: #'common' do: [
		self grease: spec.
		spec 
			package: 'Mongo-BSON';
			package: 'Mongo-Squeak' with: [ spec requires: #('Grease' 'Mongo-BSON') ];
			package: 'Mongo-Core' with: [ spec requires: #('Mongo-Squeak' 'Mongo-BSON' ) ];
			package: 'Mongo-Queries';
			package: 'Mongo-Tests-BSON' with: [ spec requires: #('Mongo-BSON' ) ];
			package: 'Mongo-Tests-Core' with: [ spec requires: #('Mongo-Core' ) ];
			package: 'Mongo-Tests-Queries' with: [
				spec requires: #('Mongo-Queries' ). ];
			package: 'Mongo-Pharo-Tools' with: [
				spec requires: #('Mongo-Core' 'Mongo-Queries') ].

		spec 
			group: 'default' with: #('Core' 'Tools' 'Tests');
			group: 'Core' with: #('Mongo-Core' 'Mongo-Queries' );
			group: 'Tools' with: #('Mongo-Pharo-Tools' );
			group: 'Tests' with: #('Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries') ].
