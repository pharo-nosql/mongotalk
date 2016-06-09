versions
version156: spec
	<version: '1.5.6' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: ''.
		spec author: 'NorbertHartl'.
		spec timestamp: '11/27/2013 14:39'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.16';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.35';
			package: 'Mongo-Core' with: 'Mongo-Core-NorbertHartl.37';
			package: 'MongoQueries' with: 'MongoQueries-NorbertHartl.7'. ].
