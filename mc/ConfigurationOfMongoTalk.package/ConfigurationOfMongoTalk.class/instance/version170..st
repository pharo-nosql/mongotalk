versions
version170: spec
	<version: '1.7.0' imports: #('1.7-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.7.0: new grease version, separate tests, ...'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '5/23/2014 14:37'.
		spec project: 'Grease' with: '1.1.9'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-TorstenBergmann.17';
			package: 'Mongo-BSON' with: 'Mongo-BSON-TorstenBergmann.41';
			package: 'Mongo-Core' with: 'Mongo-Core-TorstenBergmann.39';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-TorstenBergmann.1';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-TorstenBergmann.2';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2'.
		].
