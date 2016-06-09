versions
version13: spec
	<version: '1.3' imports: #('1.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'Add a MongoQuery object. The public interface has changed since version 1.3'.
		spec author: 'FrancoisStephany'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.0.12';
			package: 'Mongo-BSON' with: 'Mongo-BSON-FrancoisStephany.30';
			package: 'Mongo-Core' with: 'Mongo-Core-FrancoisStephany.26'. ].
