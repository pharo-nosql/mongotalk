baselines
baseline13: spec
	<version: '1.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline. 
		spec repository: 'http://smalltalkhub.com/mc/francois/MongoTalk/main'.
		
		spec 
			project: 'Grease' with: [ 
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: #stable;
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			package: 'Mongo-Squeak';
			package: 'Mongo-BSON';
			package: 'Mongo-Core'	with: [
				spec requires: #('Mongo-Squeak' 'Mongo-BSON') ] ].