versions
version14: spec
	<version: '1.4' imports: #('1.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'New query API. The public interface has changed since version 1.3'.
		spec author: 'NicolasPetton'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.0.12';
			package: 'Mongo-BSON' with: 'Mongo-BSON-FrancoisStephany.30';
			package: 'Mongo-Core' with: 'Mongo-Core-NicolasPetton.28';
			package: 'MongoQueries' with: 'MongoQueries-NicolasPetton.5'. ].
