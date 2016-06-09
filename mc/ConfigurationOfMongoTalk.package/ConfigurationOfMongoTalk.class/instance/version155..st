versions
version155: spec
	<version: '1.5.5' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'reset the authCache in case of connection change'.
		spec author: 'NorbertHartl'.
		spec timestamp: '11/27/2013 14:07'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.16';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.34';
			package: 'Mongo-Core' with: 'Mongo-Core-NorbertHartl.37';
			package: 'MongoQueries' with: 'MongoQueries-NorbertHartl.7'. ].
