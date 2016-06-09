baselines
baseline15: spec
	<version: '1.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline. 
		spec repository: 'http://smalltalkhub.com/mc/MongoTalkTeam/mongotalk/main'.
		
		spec 
			project: 'Grease' with: [ 
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: #stable;
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			package: 'Mongo-Squeak' with: [
				spec requires: #('Grease')];
			package: 'Mongo-BSON';
			package: 'Mongo-Core'	with: [
				spec requires: #('Mongo-Squeak' 'Mongo-BSON') ];
			package: 'MongoQueries' ]