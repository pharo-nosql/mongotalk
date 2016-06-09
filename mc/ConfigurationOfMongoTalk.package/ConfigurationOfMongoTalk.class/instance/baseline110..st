baselines
baseline110: spec
	<version: '1.10-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main'.
		spec project: 'Grease' with: [
				spec
					className: #ConfigurationOfGrease;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ].
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
			group: 'default' with: #('Tests' 'Tools');
			group: 'Core' with: #('Mongo-Core' 'Mongo-Queries' );
			group: 'Tools' with: #('Mongo-Pharo-Tools' );
			group: 'Tests' with: #('Mongo-Tests-BSON' 'Mongo-Tests-Core' 'Mongo-Tests-Queries'). ].
