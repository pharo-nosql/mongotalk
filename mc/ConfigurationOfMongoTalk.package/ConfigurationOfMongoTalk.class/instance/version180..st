versions
version180: spec
	<version: '1.8.0' imports: #('1.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.8.0: include tools'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '3/10/2015 14:37'.
		spec project: 'Grease' with: '1.1.9'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-TorstenBergmann.17';
			package: 'Mongo-BSON' with: 'Mongo-BSON-TorstenBergmann.42';
			package: 'Mongo-Core' with: 'Mongo-Core-TorstenBergmann.40';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-TorstenBergmann.1';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-TorstenBergmann.2';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2';
			package: 'Mongo-Pharo-Tools' with: 'Mongo-Pharo-Tools-TorstenBergmann.6'.

		].
