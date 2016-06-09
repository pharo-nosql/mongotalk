versions
version153: spec
	<version: '1.5.3' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'Strategies for generate OID'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10 September 2013 1:44:47 pm'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.15';
			package: 'Mongo-BSON' with: 'Mongo-BSON-EstebanLorenzano.33';
			package: 'Mongo-Core' with: 'Mongo-Core-DamienCassou.35';
			package: 'MongoQueries' with: 'MongoQueries-NicolasPetton.6'. ].
