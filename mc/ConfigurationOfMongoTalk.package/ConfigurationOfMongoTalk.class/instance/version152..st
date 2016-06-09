versions
version152: spec
	<version: '1.5.2' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'Bug fix for DateAndTime BSON encoding/decoding with non-zero timezone offset'.
		spec author: 'NorbertHartl'.
		spec timestamp: '7/19/2013 10:59'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.15';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.32';
			package: 'Mongo-Core' with: 'Mongo-Core-DamienCassou.35';
			package: 'MongoQueries' with: 'MongoQueries-NicolasPetton.6'. ].
