versions
version161: spec
	<version: '1.6.1' imports: #('1.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.6.1: lots of BSON fixes. OIDs, array order,...'.
		spec author: 'NorbertHartl'.
		spec timestamp: '5/23/2014 14:37'.
		spec project: 'Grease' with: '1.1.8'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.16';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.40';
			package: 'Mongo-Core' with: 'Mongo-Core-NorbertHartl.37';
			package: 'MongoQueries' with: 'MongoQueries-NorbertHartl.7'. ].
