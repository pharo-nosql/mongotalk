versions
version193: spec
	<version: '1.9.3' imports: #('1.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.9.3'.
		spec author: 'NorbertHartl'.
		spec timestamp: '3/18/2016 14:25'.
		spec project: 'Grease' with: '1.2.6'.
		spec 
			package: 'Mongo-BSON' with: 'Mongo-BSON-MartinDias.45';
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-MartinDias.18';
			package: 'Mongo-Core' with: 'Mongo-Core-MartinDias.49';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-MartinDias.2';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-HolgerHansPeterFreyther.3';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2';
			package: 'Mongo-Pharo-Tools' with: 'Mongo-Pharo-Tools-TorstenBergmann.7'. ].
