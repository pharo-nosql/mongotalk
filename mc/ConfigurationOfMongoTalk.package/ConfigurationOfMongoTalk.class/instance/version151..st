versions
version151: spec
	<version: '1.5.1' imports: #('1.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'New query API. The public interface has changed since version 1.3'.
		spec author: 'NicolasPetton'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-EstebanLorenzano.13';
			package: 'Mongo-BSON' with: 'Mongo-BSON-EstebanLorenzano.31';
			package: 'Mongo-Core' with: 'Mongo-Core-DamienCassou.35';
			package: 'MongoQueries' with: 'MongoQueries-NicolasPetton.6'. ].
