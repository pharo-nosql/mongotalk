versions
version154: spec
	<version: '1.5.4' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'added cache for authentication on databases'.
		spec author: 'NorbertHartl'.
		spec timestamp: '11/27/2013 10:43'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.16';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.34';
			package: 'Mongo-Core' with: 'Mongo-Core-NorbertHartl.36';
			package: 'MongoQueries' with: 'MongoQueries-NorbertHartl.7'. ].
