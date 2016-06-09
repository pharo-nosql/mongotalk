baselines
baseline16: spec
	<version: '1.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline. 
		spec repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main'.
		
		spec 
			project: 'Grease' with: [ 
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: #stable;
					repository: 'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ];
			package: 'Mongo-Squeak' with: [
				spec requires: #('Grease')];
			package: 'Mongo-BSON';
			package: 'Mongo-Core'	with: [
				spec requires: #('Mongo-Squeak' 'Mongo-BSON') ];
			package: 'MongoQueries' ]