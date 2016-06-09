baselines
baseline10: spec
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline. 
		spec repository: 'http://www.squeaksource.com/MongoTalk'.
		
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