versions
version190: spec
	<version: '1.9.0' imports: #('1.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'add spotter support in tools to browse default Mongo (which is changeable to an own default)'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '3/17/2015 14:37'.
		spec project: 'Grease' with: '1.1.9'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-TorstenBergmann.17';
			package: 'Mongo-BSON' with: 'Mongo-BSON-TorstenBergmann.42';
			package: 'Mongo-Core' with: 'Mongo-Core-TorstenBergmann.42';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-TorstenBergmann.1';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-TorstenBergmann.2';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2';
			package: 'Mongo-Pharo-Tools' with: 'Mongo-Pharo-Tools-TorstenBergmann.7'.

		].
