versions
version160: spec
	<version: '1.6.0' imports: #('1.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'changed baseline to include the right repo for grease'.
		spec author: 'NorbertHartl'.
		spec timestamp: '03/20/2014 14:39'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.16';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.35';
			package: 'Mongo-Core' with: 'Mongo-Core-NorbertHartl.37';
			package: 'MongoQueries' with: 'MongoQueries-NorbertHartl.7'. ].
