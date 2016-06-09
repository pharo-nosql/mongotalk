versions
version191: spec
	<version: '1.9.1' imports: #('1.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'various fixed for Pharo5'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '3/11/2016 14:37'.
		spec project: 'Grease' with: '1.1.9'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-TorstenBergmann.17';
			package: 'Mongo-BSON' with: 'Mongo-BSON-HenrikSperreJohansen.44';
			package: 'Mongo-Core' with: 'Mongo-Core-HolgerHansPeterFreyther.48';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-TorstenBergmann.1';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-HolgerHansPeterFreyther.3';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2';
			package: 'Mongo-Pharo-Tools' with: 'Mongo-Pharo-Tools-TorstenBergmann.7'.

		].
